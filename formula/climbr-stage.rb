require_relative "../lib/custom_download_strategy"

class ClimbrStage < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.8/climbr-stage.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "9b6a74bdcaa4ee7d1aca49e54b6cea88734833ed19026b2ae5bc72c02fd9fbd8"

      def install
        bin.install "climbr-stage"
      end
    end
#    if Hardware::CPU.intel?
#      url "https://github.com/myorg/mytool/releases/download/v1.1.5/mytool_1.1.5_Darwin_x86_64.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
#      sha256 "qwerty987..."
#
#      def install
#        bin.install "mytool"
#      end
#    end
  end
  
  test do
    assert_match "climbr 0.8", shell_output("#{bin}/climbr --version", 2)
  end
end