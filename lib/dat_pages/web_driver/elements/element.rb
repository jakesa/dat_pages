require 'capybara'
require 'capybara/dsl'
require_relative '../../errors'

  class DATPages::WebDriver::PageObjects::Element
    include Capybara::DSL

    attr_reader :parent, :locator, :find_by

    def initialize(locator, parent=nil, find_by=:css)
      @parent  = parent
      if locator.is_a? String
        if locator.empty?
          @locator = nil
        else
          @locator = locator
        end
      else
        @locator = locator
      end

      @find_by = find_by.to_sym

    end

    def xpath
      if @find_by == :css && @locator != nil
        Nokogiri::CSS.xpath_for(@locator)[0]
      else
        @locator
      end
    end


    # Click on an object
    #
    # @example
    #   basket_link.click
    #
    def click
      obj = find_element
      obj.click
    end

    # Double-click on an object
    #
    # @example
    #   file_image.double_click
    # @note this works but I'm not sure it does
    def double_click
      obj = find_element
      page.driver.browser.mouse.double_click(obj.native)
    end

    # Click at a specific location within an object
    #
    # @param x [Integer] X offset
    # @param y [Integer] Y offset
    # @example
    #   basket_item_image.click_at(10, 10)
    #
    def click_at(x, y)
      obj = find_element
      obj.click_at(x, y)
    end

    def set(value)
      obj = find_element
      obj.set(value)
    end

    # Send keystrokes to this object.
    #
    # @param keys [String] keys
    # @example
    #   comment_field.send_keys(:enter)
    #
    def send_keys(*keys)
      obj = find_element
      obj.send_keys(*keys)
    end

    # Does UI object exists?
    #
    # @return [Boolean]
    # @example
    #   basket_link.exists?
    #
    def exists?(visible = true)
      begin
        obj = find_element visible
      rescue DATPages::Errors::ElementNotFound
        false
      end
      obj != nil
    end

    # Is UI object visible?
    #
    # @return [Boolean]
    # @example
    #   remember_me_checkbox.visible?
    #
    def visible?(visible = false)
      obj = find_element visible
      ##--
      # this uses capybaras visible? method (which in turn is using selenium-webdrivers visible? method)
      # a visible? method that uses a different attribute or selector for determining whether or not the element is visible
      # should be defined at a higher level
      ##++
      obj.visible?
    end

    alias_method :displayed?, :visible?

    # Is UI object hidden (not visible)?
    #
    # @return [Boolean]
    # @example
    #   remember_me_checkbox.hidden?
    #
    def hidden?
      not visible?(false)
    end

    # Is UI object enabled?
    #
    # @return [Boolean]
    # @example
    #   login_button.enabled?
    #
    def enabled?
      not disabled?
    end

    # Is UI object disabled (not enabled)?
    #
    # @return [Boolean]
    # @example
    #   login_button.disabled?
    #
    def disabled?
      obj = find_element
      obj.disabled?
    end

    # Wait until the object exists, or until the specified wait time has expired.
    #
    # @param seconds [Integer or Float] wait time in seconds
    # @example
    #   run_button.wait_until_exists(0.5)
    #
    def wait_until_exists(seconds = nil)
      wait(seconds){exists?}
    rescue
      raise DATPages::Errors::ElementNotFound.new
    end

    # Wait until the object is visible, or until the specified wait time has expired.
    #
    # @param seconds [Integer or Float] wait time in seconds
    # @example
    #   run_button.wait_until_visible(0.5)
    #
    def wait_until_visible(seconds = nil)
      wait(seconds){visible?}
    rescue
      raise DATPages::Errors::ElementNotFound.new
    end

    # Wait until the object no longer exists, or until the specified wait time has expired.
    #
    # @param seconds [Integer or Float] wait time in seconds
    # @example
    #   logout_button.wait_until_gone(5)
    #
    def wait_until_gone(seconds = nil)
      wait(seconds){!exists?}
    rescue
      raise DATPages::Errors::ElementVisible.new
    end

    def wait(seconds = nil, &block)
      timeout = seconds.nil? ? Capybara.default_max_wait_time : seconds
      wait = Selenium::WebDriver::Wait.new(timeout: timeout)
      begin
       wait.until {yield block}
      rescue
        false
      end
    end

    def value
      find_element.value
    end

    def text
      find_element.text
    end

    # Hover the cursor over an object
    #
    # @example
    #   basket_link.hover
    #
    def hover
      obj = find_element
      obj.hover
    end

    def drag_by(right_offset, down_offset)
      obj = find_element
      obj.drag_by(right_offset, down_offset)
    end

    def [](attrib)
      obj = find_element
      obj[attrib]
    end

    def get_native_attribute(attrib)
      obj = find_element
      obj.native.attribute(attrib)
    end

    private
    # Note: all finds are done with xpath. If a css value is passed in, it is converted to xpath
    # TODO: JS - I might want to move the lookup code out to its own module so that it can be used at the driver level
    def find_element(visible = true)
      begin
        element = find_object(xpath, (@parent), visible)
      rescue => e
        puts e
        puts e.backtrace
        raise DATPages::Errors::ElementNotFound.new(locator)
      end
      element
    end

    def find_object(locator, parent = nil, visible = true)
      if !parent.nil? && !parent.locator.nil?
        obj = page.first(:xpath, "#{parent.xpath}", :visible => visible).first(:xpath, "#{locator}", :visible => visible)
      else
        obj = page.first(:xpath, locator, :visible => visible)
      end
      obj
    end

  end #Element
