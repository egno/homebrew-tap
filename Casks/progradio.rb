cask "progradio" do
  version "1.0.0"
  sha256 "f60d860556b5cef3970e475e23da17946bb7bef0069439577478a5af31e36e18"

  url "https://github.com/egno/progradio/releases/download/v#{version}/ProgRadio-#{version}.dmg"
  name "Prog Radio"
  desc "Menu bar player for Prog Radio with widgets and a Control Center control"
  homepage "https://github.com/egno/progradio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "ProgRadio.app"

  # Not notarized: clear the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ProgRadio.app"]
  end

  uninstall quit: "io.github.egno.ProgRadio"

  zap trash: [
    "~/Library/Containers/io.github.egno.ProgRadio",
    "~/Library/Containers/io.github.egno.ProgRadio.Widgets",
  ]
end
