require_relative "../lib/custom_download_strategy"

class ClimbrStage < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.7/climbr-stage.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "9541e654ddc994b053c0bcc1b335b176e085041f9e60eaeda05302e36c79289a"

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
    assert_match "climbr 0.7", shell_output("#{bin}/climbr --version", 2)
  end
end