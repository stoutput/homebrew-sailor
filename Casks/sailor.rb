cask "sailor" do
  arch arm: "arm64", intel: "x64"

  version "1.0.6"
  sha256 arm:   "88526b233d4240f6789479298b3f95a73eb0d82073432ef6263b3fb7ddb8535f",
         intel: "26d0bb75ab3ef95282a9908231c7454e11de8c3ac43bed9d2997e6ca731c9fff"

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
