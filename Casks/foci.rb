cask "foci" do
  version "0.2.0"
  sha256 "5ef288d4a6781e2683eeffe7653942fed30e24ece0092dc7d9a63bb486b4b5c8"

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
