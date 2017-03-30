# -*- encoding : utf-8 -*-
require 'thor'
require 'abbrev'

module VersacommerceAPI
  class Cli < Thor
    include Thor::Actions

    class ConfigFileError < StandardError
    end

    desc "list", "List all saved CONNECTIONs"
    def list
      available_connections.each do |c|
        prefix = default?(c) ? " * " : "   "
        puts prefix + c
      end
    end

    desc "add [CONNECTION]", "Create a config file for a connection named CONNECTION"
    def add(connection)
      file = config_file(connection)
      if File.exist?(file)
        raise ConfigFileError, "There is already a config file at #{file}"
      else
        config = {'protocol' => 'https'}
        config['domain']   = ask("Domain (leave blank for #{connection}.versacommerce.de):")
        config['domain']   = "#{connection}.versacommerce.de" if config['domain'].blank?
        config['domain']   = "#{config['domain']}.versacommerce.de" unless config['domain'].match(/[.:]/)
        puts "\nopen https://#{config['domain']}/admin/settings/apps in your browser to get API credentials\n"
        config['api_key']  = ask("API key :")
        config['password'] = ask("Password:")
        create_file(file, config.to_yaml)
      end
      if available_connections.one?
        default(connection)
      end
    end

    desc "remove [CONNECTION]", "Remove the config file for CONNECTION"
    def remove(connection)
      file = config_file(connection)
      if File.exist?(file)
        remove_file(default_symlink) if default?(connection)
        remove_file(file)
      else
        config_file_not_found_error(file)
      end
    end

    desc "edit [CONNECTION]", "Open the config file for CONNECTION with your default editor"
    def edit(connection=nil)
      file = config_file(connection)
      if File.exist?(file)
        if ENV['EDITOR'].present?
          system(ENV['EDITOR'], file)
        else
          puts "Please set an editor in the EDITOR environment variable"
        end
      else
        config_file_not_found_error(file)
      end
    end

    desc "show [CONNECTION]", "Show the location and contents of the CONNECTION's config file"
    def show(connection=nil)
      connection ||= default_connection
      file = config_file(connection)
      if File.exist?(file)
        puts file
        puts `cat #{file}`
      else
        config_file_not_found_error(file)
      end
    end

    desc "default [CONNECTION]", "Show or set the default connection"
    def default(connection=nil)
      if connection
        target = config_file(connection)
        if File.exist?(target)
          remove_file(default_symlink)
          `ln -s #{target} #{default_symlink}`
        else
          config_file_not_found_error(target)
        end
      end
      if File.exist?(default_symlink)
        puts "Default connection is #{default_connection}"
      else
        puts "There is no default connection set"
      end
    end

    desc "console [CONNECTION]", "Startup an API console for CONNECTION"
    def console(connection=nil)
      file = config_file(connection)

      config = YAML.load(File.read(file))
      puts ""
      puts "--> Starting interactive API console for #{config['domain']} - #{file}"
      puts ""
      VersacommerceAPI::Base.site = site_from_config(config)

      require 'irb'
      require 'irb/completion'
      ARGV.clear
      IRB.start
    end

    tasks.keys.abbrev.each do |shortcut, command|
      map shortcut => command.to_sym
    end

    private

    def shop_config_dir
      @shop_config_dir ||= File.join(ENV['HOME'], '.versacommerce', 'shops')
    end

    def default_symlink
      @default_symlink ||= File.join(shop_config_dir, 'default')
    end

    def config_file(connection)
      if connection
        File.join(shop_config_dir, "#{connection}.yml")
      else
        default_symlink
      end
    end

    def site_from_config(config)
      protocol = config['protocol'] || 'https'
      api_key  = config['api_key']
      password = config['password']
      domain   = config['domain']

      VersacommerceAPI::Base.site = "#{protocol}://#{api_key}:#{password}@#{domain}/api"
    end

    def available_connections
      @available_connections ||= begin
        pattern = File.join(shop_config_dir, "*.yml")
        Dir.glob(pattern).map { |f| File.basename(f, ".yml") }
      end
    end

    def default_connection_target
      @default_connection_target ||= File.readlink(default_symlink)
    end

    def default_connection
      @default_connection ||= File.basename(default_connection_target, ".yml")
    end

    def default?(connection)
      default_connection == connection
    end

    def config_file_not_found_error(filename)
      raise ConfigFileError, "Could not find config file at #{filename}"
    end
  end
end
