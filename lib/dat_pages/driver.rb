require 'appium_lib'
require_relative '../../lib/dat_pages'

module DATPages

  class Driver

    def self.instance
      @instance ||= Driver.new
    end

    def self.reset
      @instance = Driver.new
    end

    # launch the appium driver

    def initialize
      @started = (begin
        Appium::Driver.new(DATPages.config.desired_caps.to_hash)
        if DATPages.config.server_address != 'localhost'
          $driver.custom_url = DATPages.config.url
        end
        $driver.start_driver
        @app_open = true
        # give all the page objects the appium methods
        Appium.promote_singleton_appium_methods DATPages::PageObjects
        true
      rescue =>e
        puts e
        puts e.backtrace
        false
      end)
    end

    # start the driver if it is not already started
    def start
      if @started
        puts '[INFO] Driver has already been started'
        false
      else
        begin
          $driver.start_driver
          @app_open = true
          @started = true
        rescue
          Driver.reset
        end
        @started
      end
    end

    # stop the driver if it is running
    def stop
      if @started
        $driver.driver_quit
        @started = false
        @app_open = false
        true
      else
        puts '[INFO] Driver has already been stopped'
        false
      end
    end

    # open the app with the desired capabilities if the app isnt already open
    def open_app
      if @app_open
        puts '[INFO] application is already open'
        false
      else
        $driver.launch_app
        @app_open = false
        true
      end
    end

    # close the app if it is running
    def close_app
      if @app_open
        $driver.close_app
        @app_open = false
        true
      else
        puts '[INFO] application is already closed'
        false
      end
    end

    # send the app to the background for n seconds
    # @param seconds [Int] the number in seconds you want to send the app the background
    def send_app_to_background(seconds)
      $driver.background_app(seconds)
    end

    # waits for the given block to return true
    # @param time [Integer] the time in seconds that the waiter will wait for
    # @param block [Object] the block of code that you are waiting on
    def wait_for(time, &block)
      $driver.wait_true time, block
    end

    # TODO: I want to move all driver related tasks into the driver class. This includes finding elements. This method will be a catch all
    # for all of the different ways of finding an element so that the user only has to call one find method and the code executed will change
    # based on the parameters passed in
    def find_element(array)
      params = []
      params << array
      params.flatten!
      if array.length > 1
        $driver.find_element(array.shift, array.shift)
      elsif array.length < 1
        $driver.find(array.shift)
      end
    end

  end

end