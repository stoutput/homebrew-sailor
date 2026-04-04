cask "sailor" do
  arch arm: "arm64", intel: "x64"

  version "1.0.4"
  sha256 arm:   "0cc05e75d942abe00852116928a933cd215b015db64c558692eb65c0e29ee164",
         intel: "106be290e59d93d5f47b55e025977115a00a2078d7eb90c8b9623c58a151cd62"

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
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sailor.app"],
                   sudo: false

    begin
      require "json"
      require "fileutils"

      brew_prefix = Hardware::CPU.arm? ? "/opt/homebrew" : "/usr/local"
      plugin_path = "#{brew_prefix}/lib/docker/cli-plugins"

      docker_config_path = File.expand_path("~/.docker/config.json")
      docker_dir = File.dirname(docker_config_path)

      config = if File.exist?(docker_config_path)
        begin
          JSON.parse(File.read(docker_config_path))
        rescue JSON::ParserError
          {}
        end
      else
        {}
      end

      extra_dirs = config["cliPluginsExtraDirs"] || []
      unless extra_dirs.include?(plugin_path)
        config["cliPluginsExtraDirs"] = extra_dirs + [plugin_path]
        FileUtils.mkdir_p(docker_dir)
        File.write(docker_config_path, JSON.pretty_generate(config) + "\n")
      end
    rescue => e
      opoo "Could not update Docker CLI plugin path: #{e.message}"
    end
  end

  zap trash: [
    "~/.config/sailor",
  ]
end
