require_relative 'dat_pages/version'
require_relative 'dat_pages/config'
require_relative 'dat_pages/appium/appium_server'
require_relative '../lib/dat_pages/driver_connection'
require_relative 'dat_pages/web_driver/web_driver'
require_relative '../lib/dat_pages/web_driver/page_objects'
require_relative 'dat_pages/appium/appium'
require_relative '../lib/dat_pages/appium/page_objects'
require_relative '../lib/dat_pages/web_driver/elements/element_container'

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

  # load a config object from a JSON file
  def load_config(file_path)
    @config = DATPages::Config.load(file_path)
  end

  # write config to a json file
  # @param file_path <String> the path to the file you want to write to
  def write_config_file(file_path=nil)
    if file_path.nil?
      #generate a json file named dat_pages_config.json in the features/support directory of the current project and return the location of the file as a string
      begin
        file_path = File.expand_path(File.join("./features/support", "./test_config.json"))
        file = File.new(file_path, 'w+')
        file.write config.to_json
        file.close
        file_path
      rescue => e
        puts e.message
        puts e.backtrace
        nil
      end
    else
      #generate a json file at the location specified
      #return a boolean indicating weather or not the writing was successful
      begin
        file = File.new(file_path, 'w+')
        file.write config.to_json
        file.close
        true
      rescue
        false
      end
    end
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
