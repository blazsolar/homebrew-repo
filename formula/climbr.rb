require_relative "../lib/custom_download_strategy"

class Climbr < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.5/climbr.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "da87960d3973d2f1fe7511144734d042116b25516af74effba848b9112ead66e"

      def install
        bin.install "climbr"
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
    assert_match "climbr 0.5", shell_output("#{bin}/climbr --version", 2)
  end
end