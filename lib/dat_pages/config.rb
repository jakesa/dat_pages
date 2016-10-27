require 'appium_lib'
require_relative 'capabilities'

module DATPages

  class Config

    attr_reader :desired_caps, :os
    attr_accessor :server_address, :server_port, :server_wait_time, :default_wait_time, :driver_for, :device, :web_browser,
                  :orientation, :browser_resolution


    def initialize(os='android')
      self.os = os
      @server_address = 'localhost'
      @server_port = 4723
      @server_wait_time = 3
      @default_wait_time = 5
    end

    # set the os and change the desired capabilities accordingly
    def os=(os)
      @os = os
      @desired_caps = DATPages::Capabilities.new(os)
    end

    def url
      "http://#{@server_address}:#{@server_port}/wd/hub"
    end

    def method_missing(name, *args, &block)
      value = args[0]
      if name.match(/^.*=/) != nil
        unless respond_to?(name) || respond_to?("#{name.to_s.gsub('=','')}".to_sym)
          define_singleton_method(name) {|val|instance_variable_set("@#{name.to_s.gsub('=','')}", val)}
          define_singleton_method("#{name.to_s.gsub('=','')}") {instance_variable_get("@#{name.to_s.gsub('=','')}")}
          self.send(name, value)
        end
      else
        super
      end
    end
  end

end