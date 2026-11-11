cask "cans" do
  version "0.2.0"
  sha256 "faa09dd266193882b452444963135c588caedfeb2040267fe3621eb99424d3d4"

  url "https://github.com/egno/cans/releases/download/v#{version}/Cans-#{version}.dmg"
  name "Cans"
  desc "Unofficial menu bar app for Bose QuietComfort Ultra headphones"
  homepage "https://github.com/egno/cans"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Cans.app"

  # Not notarized: clear the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Cans.app"]
  end

  uninstall quit: "io.github.egno.cans"

  zap trash: "~/Library/Preferences/io.github.egno.cans.plist"

  caveats <<~EOS
    Pair your headphones with the Mac in System Settings first. Cans asks for the Bluetooth
    permission on first start. Release builds are signed ad hoc, so after an upgrade macOS may ask again.
  EOS
end
