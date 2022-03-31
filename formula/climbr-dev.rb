require_relative "../lib/custom_download_strategy"

class ClimbrDev < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.4/climbr-dev.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "ec904f6028f2abe88f8d404a801f28fc35f5ef007148bad8ad9d692fa963a56f"

      def install
        bin.install "climbr-dev"
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