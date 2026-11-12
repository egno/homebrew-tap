cask "cans" do
  version "0.5.0"
  sha256 "5681011b890285fec5be38718f06d8851ce20fb5c06188fc8e6682a4276881c7"

  url "https://github.com/egno/cans/releases/download/v#{version}/Cans-#{version}.dmg"
  name "Cans"
  desc "Unofficial menu bar app for Bose QuietComfort headphones"
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
