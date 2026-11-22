# rBrowser's formula in the tap degoya/homebrew-rbrowser, for Linux x86-64 (RB-110-04). Rendered from
# packaging/homebrew/rbrowser.rb.in in degoya/rBrowser by scripts/package-managers.sh, and
# replaced by the release workflow with every release: change the template, not this file.
# macOS has the cask (Casks/rbrowser.rb), since the macOS package is an app bundle. The Linux
# tarball arrives with RB-110-01; until a release carries it, this file is not written.
class Rbrowser < Formula
  desc "Development browser that shows every breakpoint of a site at once"
  homepage "https://github.com/degoya/rBrowser"
  url "https://github.com/degoya/rBrowser/releases/download/v0.9.8/rbrowser-0.9.8-linux-x64.tar.gz"
  sha256 "45745c55cb23195f0cd27ef0f4877994a9d675d382772e62510c76ff95988a40"
  version "0.9.8"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :x86_64
  depends_on :linux

  def install
    # The archive stays together in libexec: rBrowser runs CEF, Node and its bundled plugins from
    # beside the executable. bin/ gets a script that execs the real file, so the program runs from
    # the Cellar, where its update check sees that Homebrew updates it.
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"rbrowser"
  end

  def caveats
    <<~EOS
      rBrowser is a desktop program: start it from a graphical session with `rbrowser`.
      Update it with `brew upgrade rbrowser`; it does not replace itself.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rbrowser --version")
  end
end
