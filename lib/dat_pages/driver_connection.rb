require 'selenium-webdriver'
require 'capybara/dsl'
require_relative 'errors'
require_relative '../../lib/dat_pages/appium/driver'



module DATPages
  module DriverConnection
    include Capybara::DSL

    def self.initialize_driver

      driver_for = DATPages.config.driver_for
      raise DATPages::Errors::NoDriverSpecified.new if driver_for.nil?

      # TODO: Could move this out to its own class or module specific to the configuring of different drivers
      begin
        self.send(driver_for.to_sym)
      rescue NoMethodError
        raise DATPages::Errors::DriverNotFound.new(driver_for.to_sym)
      end


      # output some run information here like which driver is being used
    end

    private

    def self.appium
      DATPages::Driver.instance
    end

    def self.local_browser
      set_app_host

      Capybara.default_driver = :selenium
      Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :browser => DATPages.config.web_browser.to_sym)
      end
      # set browser size
      if DATPages.config.browser_resolution.nil? || DATPages.config.browser_resolution.empty?
        set_browser_window_size DATPages.config.browser_resolution[:width], DATPages.config.browser_resolution[:height]
      else
        set_browser_window_size 1200, 800
      end
      Capybara.current_session
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
      rescue
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

    def self.load_devices
      @devices ||= YAML.load_file File.expand_path('../../devices/devices.yml', __FILE__)
    end

  end #DriverConnection
end #DATPages
