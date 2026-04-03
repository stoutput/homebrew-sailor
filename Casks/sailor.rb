cask "sailor" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "08a4ee2356aa2f1ea3a900d2777bcca98a2028b8861ff2d0d7b954306a0c112f",
         intel: "cc50507b811415b0261d808687cf6d41176520d5d68c2711f7dc1a562901c021"

  url "https://github.com/stoutput/sailor-desktop/releases/download/v#{version}/Sailor-darwin-#{arch}-#{version}.zip"
  name "Sailor"
  desc "macOS desktop app for managing Docker containers via Colima"
  homepage "https://github.com/stoutput/sailor-desktop"

  depends_on formula: "colima"
  depends_on formula: "docker"
  depends_on formula: "docker-buildx"
  depends_on formula: "docker-compose"

  app "Sailor.app"

  zap trash: [
    "~/.config/sailor",
  ]
end
