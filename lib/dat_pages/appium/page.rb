require_relative 'elements/element_container'
require_relative 'elements/element'

  class DATPages::Appium::PageObjects::Page < DATPages::Appium::PageObjects::Element
    extend DATPages::Appium::PageObjects::ElementContainer

    def initialize
      #overriding constructor. I want the commonality that having Element as a base class gives us, but dont want to be required to pass
      #in parameters to the constructor
    end

  end