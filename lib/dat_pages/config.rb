require 'appium_lib'
require_relative 'capabilities'
require_relative 'custom_accessor'

module DATPages

  class Config
    extend CustomAccessor

    custom_attr_accessor :server_address, :server_port, :server_wait_time, :default_wait_time, :driver_for, :device, :web_browser,
                  :orientation, :browser_resolution, :driver_paths, :finder, :os, :desired_caps

    def self.load(file_path)
      #check to see that the file exists
      if File.exists? file_path
        file = File.read file_path
        file_hash = JSON.parse(file, {symbolize_names: true})
        config = new
        file_hash.each do |field, value|
          if field == :desired_caps
            value[:caps].each do |k, v|
              config.desired_caps.send("#{k}=", v)
            end
          else
            config.send("#{field}=", value)
          end
        end
        config
      else
        puts "File Not Found: #{file_path}. Loading default config."
        new
      end
      #If it doesnt, print out a warning and return a new default instance of config
      #If it does, parse the file, load the values into their coorisponding properties and return the instance
    end


    def initialize(os='android')
      self.os = os
      @server_address = 'localhost'
      @server_port = 4723
      @server_wait_time = 3
      @default_wait_time = 5
      @finder = :default
    end

    # set the os and change the desired capabilities accordingly
    def os=(os)
      @os = os
      @desired_caps = DATPages::Capabilities.new(os)
    end

    def url
      "http://#{@server_address}:#{@server_port}/wd/hub"
    end

    def to_json
      JSON.generate to_hash
    end

    def to_hash
      hash = {}
      self.class.attrs.each do |prop|
        hash[prop] =
          if prop == :desired_caps
            send(prop).to_hash
          else
            send(prop)
          end
      end
      hash
    end

    def method_missing(name, *args, &block)
      value = args[0]
      if name.match(/^.*=/) != nil
        unless respond_to?(name) || respond_to?("#{name.to_s.gsub('=','')}".to_sym)
          self.class.custom_attr_accessor name.to_s.gsub('=','').to_sym
          # define_singleton_method(name) {|val|instance_variable_set("@#{name.to_s.gsub('=','')}", val)}
          # define_singleton_method("#{name.to_s.gsub('=','')}") {instance_variable_get("@#{name.to_s.gsub('=','')}")}
          self.send(name, value)
        end
      else
        nil
      end
    end
  end

end