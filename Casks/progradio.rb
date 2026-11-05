cask "progradio" do
  version "1.1.1"
  sha256 "20011369301317ef9fb3ff42b3a08275123512f6df782da142c46503a76b77b3"

  url "https://github.com/egno/progradio/releases/download/v#{version}/ProgRadioMenuBar-#{version}.dmg"
  name "Prog Radio Menu Bar"
  desc "Menu bar player for Prog Radio with widgets and a Control Center control"
  homepage "https://github.com/egno/progradio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Prog Radio Menu Bar.app"

  # Not notarized: clear the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Prog Radio Menu Bar.app"]
  end

  uninstall quit: "io.github.egno.ProgRadio"

  zap trash: [
    "~/Library/Containers/io.github.egno.ProgRadio",
    "~/Library/Containers/io.github.egno.ProgRadio.Widgets",
  ]
end
