require 'appium_lib'
require_relative 'capabilities'


module DATPages

  class Config

    attr_reader :desired_caps, :os
    attr_accessor :server_address, :server_port


    def initialize(os='android')
      self.os = os
      @server_address = 'localhost'
      @server_port = 4723
    end

    # set the os and change the desired capabilities accordingly
    def os=(os)
      @os = os
      @desired_caps = DATPages::Capabilities.new(os)
    end

    def url
      "http://#{@server_address}:#{@server_port}/wd/hub"
    end


  end

end