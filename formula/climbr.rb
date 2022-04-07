require_relative "../lib/custom_download_strategy"

class Climbr < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.8/climbr.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "b6ccfcbd9990b70e5ae4f0b1c1bfe3305e45c66debd7470bb2a12b4546f07703"

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
    assert_match "climbr 0.8", shell_output("#{bin}/climbr --version", 2)
  end
end