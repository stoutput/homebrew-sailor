cask "sailor" do
  arch arm:   "08a4ee2356aa2f1ea3a900d2777bcca98a2028b8861ff2d0d7b954306a0c112f", intel: "cc50507b811415b0261d808687cf6d41176520d5d68c2711f7dc1a562901c021"

  version "1.0.0"
  # Update SHA256 hashes when building a new release:
  #   shasum -a 256 Sailor-<version>-darwin-arm64.zip
  #   shasum -a 256 Sailor-<version>-darwin-x64.zip
  sha256 arm:   "08a4ee2356aa2f1ea3a900d2777bcca98a2028b8861ff2d0d7b954306a0c112f",
         intel: "cc50507b811415b0261d808687cf6d41176520d5d68c2711f7dc1a562901c021"

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
