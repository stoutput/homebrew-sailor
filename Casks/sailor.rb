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

  postflight do
    system "xattr", "-dr", "com.apple.quarantine", "#{appdir}/Sailor.app"

    require "json"
    require "fileutils"

    brew_prefix = Hardware::CPU.arm? ? "/opt/homebrew" : "/usr/local"
    plugin_path = "#{brew_prefix}/lib/docker/cli-plugins"

    docker_config_path = File.expand_path("~/.docker/config.json")
    docker_dir = File.dirname(docker_config_path)

    config = if File.exist?(docker_config_path)
      JSON.parse(File.read(docker_config_path)) rescue {}
    else
      {}
    end

    extra_dirs = config["cliPluginsExtraDirs"] || []
    unless extra_dirs.include?(plugin_path)
      config["cliPluginsExtraDirs"] = extra_dirs + [plugin_path]
      FileUtils.mkdir_p(docker_dir)
      File.write(docker_config_path, JSON.pretty_generate(config) + "\n")
    end
  end

  zap trash: [
    "~/.config/sailor",
  ]
end
