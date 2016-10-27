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


  # :direction - the direction you want to swipe (up, down, left, right)
  # done within the context of the app/driver not a specific element
  # it is part of the element class to make it available to the page class
  def swipe(direction, duration=700)
    # @option opts [int] :start_x Where to start swiping, on the x axis.  Default 0.
    # @option opts [int] :start_y Where to start swiping, on the y axis.  Default 0.
    # @option opts [int] :end_x Where to end swiping, on the x axis.  Default 0.
    # @option opts [int] :end_y Where to end swiping, on the y axis.  Default 0.
    # @option opts [int] :duration How long the actual swipe takes to complete in milliseconds.
    screen_resolution = $driver.window_size
    up = {
        start_x: screen_resolution.width/2,
        start_y: screen_resolution.height/2,
        end_x: screen_resolution.width/2,
        end_y: 0001,
        duration: duration
    }
    down = {
        start_x: screen_resolution.width/2,
        start_y: screen_resolution.height/2,
        end_x: screen_resolution.width/2,
        end_y: screen_resolution.height - 10,
        duration: duration
    }
    left = {
        start_x: screen_resolution.width - 10,
        start_y: screen_resolution.height/2,
        end_x: 0200,
        end_y: screen_resolution.height/2,
        duration: duration
    }
    right = {
        start_x: 0200,
        start_y: screen_resolution.height/2,
        end_x: screen_resolution.width - 10,
        end_y: screen_resolution.height/2,
        duration: duration
    }

    case direction.to_s.downcase
      when 'up'
        $driver.swipe(up)
      when 'down'
        $driver.swipe(down)
      when 'left'
        $driver.swipe(left)
      when 'right'
        $driver.swipe(right)
      else
        raise "#{direction} is not a valid option"
    end

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

  def name
    find_element[:name]
  end

  def displayed?
    if exists?
      find_element.displayed?
    else
      false
    end
  end

  def clear
    find_element.clear
  end

  def selected?
    find_element.selected?
  end

  def exists?
    begin
      find_element
    rescue Selenium::WebDriver::Error::NoSuchElementError
      return false
    end
    true
  end


  def press_keycode(code)
    $driver.press_keycode code
  end

  def [](attribute)
    find_element[attribute]
  end




  private
  # Note: all finds are done with xpath. If a css value is passed in, it is converted to xpath
  def find_element
   raise "Not a valid Finder: #{find_by.to_sym}" unless FINDERS.include? find_by.to_sym

   case find_by.to_sym
     when :id
       $driver.find_element(find_by.to_sym, locator)
     when :value
       $driver.find(locator)
     when :xpath
       $driver.find_element(find_by.to_sym, locator)
   end
  end

end