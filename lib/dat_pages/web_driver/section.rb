require_relative 'elements/element_container'


class DATPages::WebDriver::PageObjects::Section < DATPages::WebDriver::PageObjects::Element
  extend DATPages::WebDriver::PageObjects::ElementContainer

  def self.locator
    @locator
  end

  def self.locator=(value)
    @locator=value
  end


  def initialize(locator=nil, parent = nil, find_by=:css)
    locator = self.locator ? self.locator : locator
    super(locator, parent, find_by)
  end
end
