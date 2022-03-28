require_relative "../lib/custom_download_strategy"

class Climbr < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  url "https://github.com/blazsolar/climbr-cli/releases/download/v0.1/climbr-0.1-darwind_m1.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "<SHA256>"
  head "https://github.com/blazsolar/climbr-cli.git"

  def install
    bin.install "climbr"
  end
  
  test do
    assert_match "climbr 0.1", shell_output("#{bin}/climbr --version", 2)
  end
end