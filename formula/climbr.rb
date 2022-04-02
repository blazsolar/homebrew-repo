require_relative "../lib/custom_download_strategy"

class Climbr < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.7/climbr.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "52f5722e736582588d21b714ba68143b40e7fa309e462a71f99b91e5bdf657b8"

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
    assert_match "climbr 0.7", shell_output("#{bin}/climbr --version", 2)
  end
end