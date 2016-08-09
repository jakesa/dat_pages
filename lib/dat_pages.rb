require 'dat_pages/version'
require_relative 'dat_pages/config'
require_relative 'dat_pages/appium_server'

module DATPages

  class << self

    def config
      @config ||= DATPages::Config.new
    end

    def configure
      @config ||= DATPages::Config.new
      yield(@config) if block_given?
      @config
    end

    def reset
      @config = DATPages::Config.new
    end

    def server
      if DATPages.config.server_address == 'localhost'
        @server ||= DATPages::AppiumServer.new
      else
        DATPages.config.url
      end
    end

    def start_driver
      # start the driver with the desired caps
      begin
        Appium::Driver.new(DATPages.config.desired_caps.to_hash)
        if DATPages.config.server_address != 'localhost'
          $driver.custom_url = DATPages.config.url
        end
        $driver.start_driver

        # give all the page objects the appium methods
        Appium.promote_singleton_appium_methods DATPages::PageObjects
        true
      rescue =>e
        puts e
        puts e.backtrace
        false
      end
    end

    def stop_driver
      $driver.driver_quit
    end

  end
end
