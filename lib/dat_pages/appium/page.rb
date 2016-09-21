require_relative 'elements/element_container'
require_relative 'elements/element'

  class DATPages::Appium::PageObjects::Page < DATPages::Appium::PageObjects::Element
    extend DATPages::Appium::PageObjects::ElementContainer

    def initialize()
      #overriding constructor
    end

  end