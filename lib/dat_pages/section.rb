require_relative 'element'
require 'appium_lib'

module DATPages

  class Section
    Appium.promote_appium_methods self
    include DATPages::Element

    def self.section(name, klass, selector)

    end

    def initialize

    end

  end

end