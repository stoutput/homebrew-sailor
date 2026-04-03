cask "sailor" do
  arch arm: "arm64", intel: "x64"

  version "1.0.1"
  sha256 arm:   "a2f1be7324ee987a04d666422e6375313601b037eea457bd6f450eae714d4751",
         intel: "a80d4f34d3bee9bb9d6b683bdaa55c0a47b1e799190798c0198b3a297b090a04"

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
