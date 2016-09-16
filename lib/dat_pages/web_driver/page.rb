require_relative 'elements/element_container'
require_relative 'elements/element'

class DATPages::WebDriver::PageObjects::Page < DATPages::WebDriver::PageObjects::Element
  extend DATPages::WebDriver::PageObjects::ElementContainer
end
