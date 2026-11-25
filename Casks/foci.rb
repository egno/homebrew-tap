cask "foci" do
  version "1.0.4"
  sha256 "9220dbae6b07d0719f494562aa76fe6801d6010b5e443afabde0f942fcc591eb"

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
    Foci needs the Accessibility permission (it asks on first start). Releases from 1.0.4 on are signed
    with one certificate, so updates keep it. Upgrading from an older version asks once more: if Foci's
    switch is on but nothing happens, remove Foci from System Settings → Privacy & Security →
    Accessibility and add it back.
  EOS
end
