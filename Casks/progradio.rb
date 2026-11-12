cask "progradio" do
  version "1.3.2"
  sha256 "5faaae888df7cce1cc57422117a8a6d444f15e15bdc023e993abfffd1c8ffdaf"

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
