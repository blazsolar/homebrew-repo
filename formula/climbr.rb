require_relative "../lib/custom_download_strategy"

class Climbr < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  url "https://github.com/blazsolar/climbr-cli/releases/download/v0.2/climbr.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "dc081dc727f68a648486c7d3cf341ecc7d1c8aed1c958d0049fd64a2cc05e4b7"
  head "https://github.com/blazsolar/climbr-cli.git"

  def install
    bin.install "climbr"
  end
  
  test do
    assert_match "climbr 0.1", shell_output("#{bin}/climbr --version", 2)
  end
end