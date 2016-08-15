require 'dat_pages/version'
require_relative 'dat_pages/config'
require_relative 'dat_pages/appium_server'

module DATPages

  self.extend ::DATPages

  def config
    @config ||= DATPages::Config.new
  end

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
    @server
  end

  # start the local appium server
  # @return [Boolean]
  def start_server
      @server ||= DATPages::AppiumServer.new
      @server.start
  end

  # stop the local appium server
  # @return [Boolean]
  def stop_server
    @server.stop
  end

  # check to see if a remote server has been sepcified
  # @return [Boolean]
  def remote_server?
    if DATPages.config.server_address != nil && DATPages.config.server_address != 'localhost'
      true
    else
      false
    end
  end

  # get the url for the remote server
  # @return [String] the url
  def remote_server
    DATPages.config.url
  end

  # start the driver
  # @return [Boolean]
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

  # stop the driver
  def stop_driver
    $driver.driver_quit
  end

  # get a reference to the current driver
  #--
  # TODO: Should I wrap the driver it a custom driver class? I probably should
  #++
  def driver
    $driver
  end

end
