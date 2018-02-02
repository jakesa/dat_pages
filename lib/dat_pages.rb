require_relative 'dat_pages/version'
require_relative 'dat_pages/config'
require_relative 'dat_pages/appium/appium_server'
require_relative '../lib/dat_pages/driver_connection'
require_relative 'dat_pages/web_driver/web_driver'
require_relative '../lib/dat_pages/web_driver/page_objects'
require_relative 'dat_pages/appium/appium'
require_relative '../lib/dat_pages/appium/page_objects'
require_relative '../lib/dat_pages/web_driver/elements/element_container'
require_relative 'dat_pages/appium/elements/element'
require_relative 'dat_pages/appium/section'
require_relative 'dat_pages/appium/page'

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
    reset_config
    reset_driver
  end

  def reset_config
    @config = DATPages::Config.new
  end

  def reset_driver
    if @driver
      @driver.dispose
      @driver = nil
    end
  end

  # get the current instance of the server
  # @return [DATPages::AppiumServer]
  def server
    @server ||= DATPages::Appium::AppiumServer.new
  end


  # get a reference to the current driver
  # @return [DATPages::Driver]
  def driver
    # DATPages::Driver.instance
    @driver ||= DATPages::DriverConnection.initialize_driver
  end

end
