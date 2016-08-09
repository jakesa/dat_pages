require_relative 'element_container'
require 'appium_lib'

module DATPages

  class Page
    extend DATPages::ElementContainer

    def initialize
      Appium.promote_appium_methods self.class
      @driver = $driver
    end


  end

end