cask "progradio" do
  version "1.2.0"
  sha256 "5ad06d194eaab8b34b161285e45efe38bde0cd5073f3e5d31ed5a3fb9961e178"

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
