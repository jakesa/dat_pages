
module DATPages
  module Errors
    class ElementNotFound < StandardError
      def initialize(locator=nil)
        if locator.nil?
          str = 'Unable to find element'
        else
          str = "Unable to find element with #{locator}"
        end
        super str
      end
    end #ElementNotFound

    class ElementVisible < StandardError
      def initialize(locator=nil)
        if locator.nil?
          str = 'Element remained visible'
        else
          str = "Element with selector #{locator} remained visible"
        end
        super str
      end
    end #ElementVisible

    class ElementNotVisible < StandardError
      def initialize(locator=nil)
        if locator.nil?
          str = 'Element was not visible'
        else
          str = "Element with selector #{locator} was not visible"
        end
        super str
      end
    end #ElementNotVisible

    class NoAppHost <StandardError
      def initialize
        super 'No app_host was set. Either pass it in or set DATPages.config.app_host'
      end
    end #NoAppHost

    class NoDriverSpecified < StandardError
      def initialize
        super 'No driver was specified. Set DATPages.config.driver_for with the driver you want to initialize (Example: :firefox)'
      end
    end

    class DriverNotFound < StandardError
      def initialize(driver)
        super "The driver #{driver} is not a valid driver"
      end
    end

    class WebBrowserNotSet < StandardError
      def initialize
        super 'DATPages.config.web_browser has not been set'
      end
    end

    class BrowserNotSupported < StandardError
      def initialize(browser)
        super "#{browser} is not a supported browser"
      end
    end

    class DeviceNotSpecified < StandardError
      def initialize
        super 'No device have been specified'
      end
    end

    class DeviceNotFound < StandardError
      def initialize(device)
        super "#{device} was not found in the list of supported devices"
      end
    end

  end #Errors
end #DATPages