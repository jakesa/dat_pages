require_relative 'dat_pages/version'
require_relative 'dat_pages/config'
require_relative 'dat_pages/appium/appium_server'
require_relative '../lib/dat_pages/driver_connection'
require_relative 'dat_pages/web_driver/web_driver'
require_relative '../lib/dat_pages/web_driver/page_objects'
require_relative 'dat_pages/appium/appium'
require_relative '../lib/dat_pages/appium/page_objects'

module DATPages

  self.extend ::DATPages

  # get the config object
  # @return [DATPages::Config]
  def config
    @config ||= DATPages::Config.new
  end

  # specify the config object
  # takes a block to configure the object
  # Example:
  #   DATPages.configure do |config|
  #     config.os = 'ios'
  #     config.desired_caps.autoAcceptAlerts = true
  #     config.desired_caps.fullReset = true
  #     config.desired_caps.platformName = 'ios'
  #     config.desired_caps.deviceName = 'iPhone 6'
  #     config.desired_caps.platformVersion = '9.3'
  #     config.desired_caps.app = '/Users/jakesa/Library/Developer/Xcode/DerivedData/mobile-fexownuxytnyvddyyujpnerxqobm/Build/Products/Debug-iphonesimulator/Trucker.app'
  #   end
  # @return [DATPages::Config]
  def configure
    @config ||= DATPages::Config.new
    yield(@config) if block_given?
    @config
  end

  # reset the global config
  # @return [DATPages::Config]
  def reset
    @config = DATPages::Config.new
  end

  # get the current instance of the server
  # @return [DATPages::AppiumServer]
  def server
    @server ||= DATPages::AppiumServer.new
  end
  #
  # # start the local appium server
  # # @return [Boolean]
  # def start_server
  #   if remote_server?
  #     puts '[INFO] Server not started. Setting indicated a remote server was specified.'
  #     false
  #   else
  #     @server ||= DATPages::AppiumServer.new
  #     @server.start
  #   end
  # end
  #
  # # stop the local appium server
  # # @return [Boolean]
  # def stop_server
  #   if @server.nil?
  #     puts '[INFO] No server has been started.'
  #     false
  #   else
  #     @server.stop
  #   end
  # end
  #
  # # check to see if a remote server has been specified
  # # @return [Boolean]
  # def remote_server?
  #   if DATPages.config.server_address != nil && DATPages.config.server_address != 'localhost'
  #     true
  #   else
  #     false
  #   end
  # end
  #
  # # get the url for the remote server
  # # @return [String] the url
  # def remote_server
  #   DATPages.config.url
  # end
  #
  # # start the driver
  # # @return [Boolean]
  # def start_driver
  #   # start the driver with the desired caps
  #   DATPages::Driver.instance.start
  # end
  #
  # # stop the driver
  # # @return [Boolean]
  # def stop_driver
  #   DATPages::Driver.instance.stop
  # end

  # get a reference to the current driver
  # @return [DATPages::Driver]
  def driver
    # DATPages::Driver.instance
    @driver ||= DATPages::DriverConnection.initialize_driver
  end
  #
  # # close the application
  # # @return [Boolean]
  # def close_app
  #   DATPages::Driver.instance.close_app
  # end
  #
  # # open the application
  # # @return [Boolean]
  # def open_app
  #   DATPages::Driver.instance.open_app
  # end

  # # send app to the background
  # # it will come back to the foreground when the timer has run out
  # # @param seconds [Int] the amount of time in seconds you want the app to be in the background
  # def send_app_to_background(seconds)
  #   DATPages::Driver.instance.send_app_to_background seconds
  # end


end
