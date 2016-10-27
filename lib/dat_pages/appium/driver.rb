require 'appium_lib'
require_relative '../../../lib/dat_pages'
# I am going to have to namespace this to Appium in the near future
module DATPages

  class Driver

    def self.instance
      @instance ||= Driver.new
    end

    def self.reset
      @instance = Driver.new
    end

    def self.dispose
      @instance = nil
    end

    # launch the appium driver

    def initialize
      @started = (begin
        Object::Appium::Driver.new(DATPages.config.desired_caps.to_hash)
        if DATPages.config.server_address != 'localhost'
          $driver.custom_url = DATPages.config.url
        end
        $driver.start_driver
        @app_open = true
        # give all the page objects the appium methods
        true
      rescue =>e
        puts e
        puts e.backtrace
        false
      end)
    end

    def dispose
      stop
      self.class.dispose
    end

    def status
      if @started
        'Started'
      elsif @started.nil? || !@started
        'Not Started'
      end
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
        rescue =>e
          raise e
          # Object::Appium::Driver.restart
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

    def set_location(loc)
      raise 'location hash should include keys :lat, :long' unless loc.has_key?(:lat) && loc.has_key?(:long)
      location = {latitude: loc[:lat], longitude: loc[:long]}
      $driver.set_location location
    end

    # send the app to the background for n seconds
    # @param seconds [Int] the number in seconds you want to send the app the background
    def send_app_to_background(seconds)
      $driver.background_app(seconds)
    end

    # waits for the given block to return true
    # @param seconds [Integer] the time in seconds that the waiter will wait for
    # @param block [Object] the block of code that you are waiting on
    def wait_for(seconds, &block)
      result = false
      seconds.times do
        begin
          result = yield block
          if result
            return result
          else
            sleep 1
          end
        rescue
          sleep 1
          next
        end
      end
      result
    end

    # TODO: I want to move all driver related tasks into the driver class. This includes finding elements. This method will be a catch all
    # for all of the different ways of finding an element so that the user only has to call one find method and the code executed will change
    # based on the parameters passed in
    # TODO: write unit test
    def find_element(*args)
      args = parse_element_args args
      element = DATPages::Appium::PageObjects::Element.new args[:locator], nil, args[:find_by]
      if element.exists?
        element
      else
        raise Selenium::WebDriver::Error::NoSuchElementError
      end
    end
    #
    # def find_elements(*args)
    #   args = parse_element_args(args)
    #   elements = $driver.find_elements(args[:find_by], args[:locator])
    #   elements.each
    # end

    def get_element_count(*args)
      args = parse_element_args args
      $driver.find_elements(args[:find_by], args[:locator]).length
    end

    private

    def parse_element_args(args)
      case args.length
        when 1
          {locator: args[0], find_by: :id}
        when 2
          {find_by: args[0], locator: args[1]}
        else
          raise ArgumentError.new("Wrong number of arguments. Expected 1 or 2, got #{args.length}")
      end
    end

  end

end