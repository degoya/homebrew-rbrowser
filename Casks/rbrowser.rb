# rBrowser's cask in the tap degoya/homebrew-rbrowser, for macOS (RB-110-04). Rendered from
# packaging/homebrew/rbrowser-cask.rb.in in degoya/rBrowser by scripts/package-managers.sh as
# Casks/rbrowser.rb, and replaced by the release workflow with every release: change the
# template, not this file. Linux has the formula (Formula/rbrowser.rb); casks are macOS only.
# The archives are those scripts/package-macos.sh writes and release.yml's `macos` job publishes
# (RB-090-80); a release without them writes no cask.
cask "rbrowser" do
  version "0.9.8"

  on_arm do
    url "https://github.com/degoya/rBrowser/releases/download/v0.9.8/rbrowser-0.9.8-macos-aarch64.zip"
    sha256 "dd1112220675126ed705a7e6acc0f17235abb88e15545bfce6ffe017449a967e"
  end
  on_intel do
    url "https://github.com/degoya/rBrowser/releases/download/v0.9.8/rbrowser-0.9.8-macos-x86_64.zip"
    sha256 "8e9ee7090b23ab44c411d259feeb117fb84254b58af22de15ba58eb76e8c137a"
  end

  name "rBrowser"
  desc "Development browser that shows every breakpoint of a site at once"
  homepage "https://github.com/degoya/rBrowser"

  livecheck do
    url "https://github.com/degoya/rBrowser"
    strategy :github_latest
  end

  # LSMinimumSystemVersion of the bundle (scripts/lib/macos-bundle.sh): 13.0.
  depends_on macos: ">= :ventura"

  app "rBrowser.app"
  binary "#{appdir}/rBrowser.app/Contents/MacOS/rbrowser"

  # The settings and the state (logs and the like) where rBrowser keeps them on macOS
  # (rb-config's dirs.rs).
  zap trash: [
    "~/.config/rbrowser",
    "~/.local/state/rBrowser",
  ]

  caveats <<~EOS
    rBrowser is signed ad hoc, not notarised. On its first start macOS asks whether to open
    it: allow it under System Settings, Privacy & Security, Open Anyway (on macOS 14 and
    earlier a right-click on the app and Open does the same), or remove the quarantine flag:
      xattr -dr com.apple.quarantine /Applications/rBrowser.app
    The handbook's installation page shows the steps:
      https://github.com/degoya/rBrowser/wiki/installation

    Update it with `brew upgrade rbrowser`; it does not replace itself.
  EOS
end
