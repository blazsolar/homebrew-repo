require "download_strategy"

class Climbr < Formula
  desc "CLI interface for climbr app"
  homepage "https://github.com/blazsolar/climbr-cli"
  url "git@github.com:blazsolar/climbr-cli.git", :using => GitHubGitDownloadStrategy
  sha256 "<SHA256>"
  head "https://github.com/blazsolar/climbr-cli.git"

  def install
    bin.install "climbr"
  end
  
  test do
    assert_match "climbr 0.1", shell_output("#{bin}/climbr --version", 2)
  end
end