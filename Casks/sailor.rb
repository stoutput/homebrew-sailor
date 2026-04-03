cask "sailor" do
  arch arm: "arm64", intel: "x64"

  version "7.0.0"
  # Update SHA256 hashes when building a new release:
  #   shasum -a 256 Sailor-<version>-darwin-arm64.zip
  #   shasum -a 256 Sailor-<version>-darwin-x64.zip
  sha256 arm:   :no_check,
         intel: :no_check

  url "https://github.com/stoutput/sailor-desktop/releases/download/v#{version}/Sailor-#{version}-darwin-#{arch}.zip"
  name "Sailor"
  desc "macOS desktop app for managing Docker containers via Colima"
  homepage "https://github.com/stoutput/sailor-desktop"

  depends_on formula: "stoutput/sailor/colima@0.9.1"
  depends_on formula: "stoutput/sailor/docker@27.5.1"

  app "Sailor.app"

  zap trash: [
    "~/.config/sailor",
  ]
end
