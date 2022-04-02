require_relative "../lib/custom_download_strategy"

class ClimbrDev < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  head "https://github.com/blazsolar/climbr-cli.git"
  version "0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blazsolar/climbr-cli/releases/download/v0.7/climbr-dev.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "4027370fa8acd8898cd8ee2e188224ecd48eb27aac976f58674ad03c14a3766d"

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
    assert_match "climbr 0.7", shell_output("#{bin}/climbr --version", 2)
  end
end