cask "foci" do
  version "0.2.1"
  sha256 "6fa4570e65379113c57183bcda6e6039bab53d3c57c1dc89b18e5a05289b2002"

  url "https://github.com/egno/foci/releases/download/v#{version}/Foci-#{version}.dmg"
  name "Foci"
  desc "Keyboard-first window manager for working on one project at a time"
  homepage "https://github.com/egno/foci"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Foci.app"
  binary "#{appdir}/Foci.app/Contents/MacOS/foci"

  # Not notarized: clear the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Foci.app"]
  end

  # Foci puts every parked window back on screen when it quits.
  uninstall quit: "dev.foci.Foci"

  zap trash: [
    "~/.config/foci",
    "~/Library/Application Support/Foci",
  ]

  caveats <<~EOS
    Foci needs the Accessibility permission (it asks on first start). Release builds are signed ad hoc,
    so after an upgrade macOS may ask again: remove Foci from System Settings → Privacy & Security →
    Accessibility and add it back.
  EOS
end
