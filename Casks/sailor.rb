cask "sailor" do
  arch arm: "arm64", intel: "x64"

  version "1.0.2"
  sha256 arm:   "7997e7d0d2b182a5d4d90fde747f427c1f53141b8cd4dfe1c23ddb71ddc19006",
         intel: "2568e4c15fecc172152e8ae90d44d5f27b0251e03a34a5fb8d4f0670fed0e918"

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
