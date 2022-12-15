require "download_strategy"

# GitHubPrivateRepositoryDownloadStrategy downloads contents from GitHub
# Private Repository. To use it, add
# `:using => :github_private_repo` to the URL section of
# your formula. This download strategy uses GitHub access tokens (in the
# environment variables `HOMEBREW_GITHUB_API_TOKEN`) to sign the request.  This
# strategy is suitable for corporate use just like S3DownloadStrategy, because
# it lets you use a private GitHub repository for internal distribution.  It
# works with public one, but in that case simply use CurlDownloadStrategy.
class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
    require "utils/formatter"

    def initialize(url, name, version, **meta)
        super
        parse_url_pattern
    end

    def gh_executable
        formula = Formula["gh"]
        @gh ||= [
            ENV["HOMEBREW_GH"],
            which("gh"),
            "#{formula.latest_installed_prefix}/bin/gh",
        ].compact.map { |c| Pathname(c) }.find(&:executable?)
        raise "No executable `gh` was found" unless @gh

        @gh
    end

    def parse_url_pattern
        unless match = url.match(%r{https://github.com/([^/]+)/([^/]+)/(\S+)})
        raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Repository."
    end

    _, @owner, @repo, @filepath = *match
  end

    def download_url
        "https://#{@github_token}@github.com/#{@owner}/#{@repo}/#{@filepath}"
    end

    private

    def _fetch(url:, resolved_url:, timeout:)
        result = system_command(
            gh_executable,
            args: ['api', @download_url, '>', @temporary_path],
            must_succeed: true
        )
    end
    
end

# GitHubPrivateRepositoryReleaseDownloadStrategy downloads tarballs from GitHub
# Release assets. To use it, add `:using => :github_private_release` to the URL section
# of your formula. This download strategy uses GitHub access tokens (in the
# environment variables HOMEBREW_GITHUB_API_TOKEN) to sign the request.
class GitHubPrivateRepositoryReleaseDownloadStrategy < GitHubPrivateRepositoryDownloadStrategy
  def initialize(url, name, version, **meta)
    super
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  private

    def _fetch(url:, resolved_url:, timeout:)
        result = system_command(
            gh_executable,
            args: ['release', 'download', '-R', "#{@owner}/#{@repo}", @tag, '-p', @filename, '-O', @temporary_path],
            must_succeed: true
        )
    end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_metadata = fetch_release_metadata
    assets = release_metadata["assets"].select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset file not found." if assets.empty?

    assets.first["id"]
  end

  def fetch_release_metadata
    release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    GitHub::API.open_rest(release_url)
  end
end

class DownloadStrategyDetector
  class << self
    module Compat
      def detect_from_symbol(symbol)
        case symbol
        when :github_private_repo
          GitHubPrivateRepositoryDownloadStrategy
        when :github_private_release
          GitHubPrivateRepositoryReleaseDownloadStrategy
        else
          super(symbol)
        end
      end
    end

    prepend Compat
  end
end
