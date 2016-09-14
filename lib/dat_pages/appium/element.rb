require 'appium_lib'
require_relative 'appium'
class Element


  attr_reader :parent, :locator, :find_by

  FINDERS = {
      :class             => 'class name',
      :class_name        => 'class name',
      :css               => 'css selector',
      :id                => 'id',
      :link              => 'link text',
      :link_text         => 'link text',
      :name              => 'name',
      :partial_link_text => 'partial link text',
      :tag_name          => 'tag name',
      :xpath             => 'xpath'
  }

  def initialize(locator, parent=nil, find_by=:text)
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
    find_element.displayed?
  end

  def [](attribute)
    find_element[attribute]
  end


  private
  # Note: all finds are done with xpath. If a css value is passed in, it is converted to xpath
  def find_element
   raise 'Not a valid Finder' unless FINDERS.include? @find_by
   if @parent != nil
     $driver.find_element(@parent.find_by, @parent.locator).find_element(@find_by, @locator)
   else
     $driver.find_element(@find_by, @locator)
   end
  end

end