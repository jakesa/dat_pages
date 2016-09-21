require_relative 'elements/element_container'
require_relative 'elements/element'

class DATPages::WebDriver::PageObjects::Page

  attr_accessor :url
  extend DATPages::WebDriver::PageObjects::ElementContainer
end
