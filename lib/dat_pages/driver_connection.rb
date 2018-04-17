require 'selenium-webdriver'
require 'capybara/dsl'
require_relative 'errors'
require_relative '../../lib/dat_pages/appium/driver'
require_relative '../../lib/dat_pages/web_driver/driver'
require_relative '../../lib/dat_pages/web_api/driver'



module DATPages
  module DriverConnection
    include Capybara::DSL

    def self.initialize_driver

      driver_for = DATPages.config.driver_for
      raise DATPages::Errors::NoDriverSpecified.new if driver_for.nil?

      # TODO: Could move this out to its own class or module specific to the configuring of different drivers
      self.send(driver_for.to_sym)
      # begin
      #   self.send(driver_for.to_sym)
      # rescue NoMethodError => e
      #   puts e
      #   puts e.backtrace
      #   raise DATPages::Errors::DriverNotFound.new(driver_for.to_sym)
      # end


      # output some run information here like which driver is being used
    end

    private

    def self.appium
      DATPages::Driver.instance
    end

    def self.web_api
      DATPages::WebAPI::Driver.instance
    end

    def self.local_browser
      set_app_host
      set_driver_path

      # Capybara.run_server = false
      Capybara.default_driver = :selenium
      Capybara.register_driver :selenium do |app|
        if DATPages.config.web_browser.to_sym == :firefox
          Capybara::Selenium::Driver.new(app, :browser => :firefox, :marionette => true)
        else
          Capybara::Selenium::Driver.new(app, :browser => DATPages.config.web_browser.to_sym)
        end
      end

      # set browser size
      if !DATPages.config.browser_resolution.nil? && !DATPages.config.browser_resolution.empty?
        set_browser_window_size DATPages.config.browser_resolution[:width], DATPages.config.browser_resolution[:height]
      else
        set_browser_window_size 1200, 800
      end

      DATPages::WebDriver::Driver.instance
    end

    def self.remote_browser
      set_app_host
      # driver = Selenium::WebDriver.for :remote, url: DATPages.config.remote_url, desired_capabilities: DATPages.config.web_browser.to_sym

      Capybara.register_driver :selenium_grid do |app|
        caps = {:browser => :remote, :url => DATPages.config.remote_url, :desired_capabilities => {:browserName => DATPages.config.web_browser}}
        Capybara::Selenium::Driver.new(app, caps)

      end

      Capybara.current_driver = :selenium_grid

      # # set browser size
      if !DATPages.config.browser_resolution.nil? && !DATPages.config.browser_resolution.empty?
        set_browser_window_size DATPages.config.browser_resolution[:width], DATPages.config.browser_resolution[:height]
      else
        set_browser_window_size 1200, 800
      end
      # binding.pry
      DATPages::WebDriver::Driver.instance
    end

    def self.local_mobile_browser
      set_app_host
      device = get_device
      Capybara.default_driver = :selenium
      Capybara.register_driver :selenium do |app|
        case get_browser
          when :firefox
            profile = Selenium::WebDriver::Firefox::Profile.new
            profile['general.useragent.override'] = device[:user_agent]
            Capybara::Selenium::Driver.new(app, :profile => profile)
          when :chrome
            args = []
            args << "--user-agent='#{device[:user_agent]}'"
            Capybara::Selenium::Driver.new(app, :browser => :chrome, :args => args)

          else
            raise DATPages::Errors::BrowserNotSupported.new(get_browser)
        end
      end
      configure_device(device)
      Capybara.current_session
    end

    def self.set_app_host
      begin
        Capybara.app_host = DATPages.config.app_host
      rescue => e
        puts e
        raise DATPages::Errors::NoAppHost.new
      end
    end

    def self.get_browser
      begin
        DATPages.config.web_browser
      rescue
        raise DATPages::Errors::WebBrowserNotSet.new
      end
    end

    def self.configure_device(device)

      if DATPages.config.orientation.nil?
        set_device_orientation device, nil
      else
        set_device_orientation device, DATPages.config.orientation
      end
    end

    def self.set_device_orientation(data, orientation)
      if orientation != nil && orientation != data[:orientation]
        set_browser_window_size data[:height], data[:width]
      else
        set_browser_window_size data[:width], data[:height]
      end
    end

    def self.set_browser_window_size(width, height)
      window = Capybara.current_session.driver.browser.manage.window
      window.resize_to(width, height)
    end

    def self.get_device
      # TODO: This can be a database call later with adding and removing support for devices managed via a web app
      begin
        device = DATPages.config.device
      rescue
        DATPages::Errors::DeviceNotSpecified.new
      end
      raise DATPages::Errors::DeviceNotFound.new(device) unless load_devices.include? device.to_sym
      load_devices[device.to_sym]
    end

    def self.set_driver_path
      if DATPages.config.driver_paths
        DATPages.config.driver_paths.each do |driver, path|
          case driver
            when :chrome
              Selenium::WebDriver::Chrome.driver_path = path
            when :ie
              Selenium::WebDriver::IE.driver_path = path
            when :edge
              Selenium::WebDriver::Edge.driver_path = path

          end
        end
        return 'Ok'
      end
      nil
    end

    def self.load_devices
      @devices ||= YAML.load_file File.expand_path('../../devices/devices.yml', __FILE__)
    end

  end #DriverConnection
end #DATPages
