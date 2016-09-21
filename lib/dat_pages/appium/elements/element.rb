require 'appium_lib'
class DATPages::Appium::PageObjects::Element


  attr_reader :parent, :locator, :find_by

  FINDERS = {
      :class             => 'class name',
      :class_name        => 'class name',
      :id                => 'id',
      :name              => 'name',
      :xpath             => 'xpath',
      :value             => 'value'
  }

  def initialize(locator, parent=nil, find_by=:id)
    @parent  = parent
    @locator = locator
    @find_by = find_by

  end
  # actions list
  # e.name # button, text
  # e.value # secure, textfield
  # e.type 'some text' # type text into textfield
  # e.clear # clear textfield
  # e.tag_name # calls .type (patch.rb)
  # e.text
  # e.size
  # e.location
  # e.rel_location
  # e.click
  # e.send_keys 'keys to send'
  # e.displayed? # true or false depending if the element is visible
  # e.selected? # is the tab selected?
  # e.attribute('checked')

  def type(value)
    find_element.type value
  end

  def click
    find_element.click
  end

  def send_keys(keys)
    find_element.send_keys keys
  end

  def text
    find_element.text
  end

  def displayed?
    if exists?
      find_element.displayed?
    else
      false
    end
  end

  def exists?
    begin
      find_element
    rescue Selenium::WebDriver::Error::NoSuchElementError
      return false
    end
    true
  end

  def [](attribute)
    find_element[attribute]
  end


  private
  # Note: all finds are done with xpath. If a css value is passed in, it is converted to xpath
  def find_element
   raise "Not a valid Finder: #{find_by.to_sym}" unless FINDERS.include? find_by.to_sym
   # TODO: will add more as needed
   case find_by.to_sym
     when :id
       $driver.find_element(find_by.to_sym, locator)
     when :value
       $driver.find(locator)
   end
  end

end