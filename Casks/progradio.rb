cask "progradio" do
  version "1.3.1"
  sha256 "fc106e1355cbb519c958e698346c5f1abc8610fa942b7e1c665e37ea2490f9ca"

  url "https://github.com/egno/progradio/releases/download/v#{version}/ProgRadioMini-#{version}.dmg"
  name "Prog Radio Mini"
  desc "Menu bar player for Prog Radio with widgets and a Control Center control"
  homepage "https://github.com/egno/progradio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Prog Radio Mini.app"

  # Not notarized: clear the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Prog Radio Mini.app"]
  end

  uninstall quit: "io.github.egno.ProgRadio"

  zap trash: [
    "~/Library/Containers/io.github.egno.ProgRadio",
    "~/Library/Containers/io.github.egno.ProgRadio.Widgets",
  ]
end
