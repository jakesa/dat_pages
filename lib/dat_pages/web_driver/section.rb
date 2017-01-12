require_relative 'elements/element_container'


class DATPages::WebDriver::PageObjects::Section < DATPages::WebDriver::PageObjects::Element
  extend DATPages::WebDriver::PageObjects::ElementContainer

  def initialize(locator=nil, parent = nil, find_by=:css)
    super
  end
end
