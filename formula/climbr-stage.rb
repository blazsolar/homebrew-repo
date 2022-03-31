require_relative "../lib/custom_download_strategy"

class ClimbrStage < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.4/climbr-stage.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "0e550f55fabfec80a3529aa6113bfde032f8877d56adf6b1b8222ab626ea02fe"

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
    assert_match "climbr 0.4", shell_output("#{bin}/climbr --version", 2)
  end
end