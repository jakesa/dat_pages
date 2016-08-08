require_relative 'element'
require_relative 'section'
require 'appium_lib'

module DATPages

  class Page
    Appium.promote_appium_methods self
    include DATPages::Element
    include DATPages::Section

    def initialize
      @driver = $driver
    end


  end

end