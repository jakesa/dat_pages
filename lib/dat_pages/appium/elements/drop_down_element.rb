require_relative 'element'

# TODO - write unit test
module DATPages::Appium::PageObjects
  class DropDownElement < DATPages::Appium::PageObjects::Element
    # Note: This was written specifically for android and my come back to bite me in the ass when I try to use it
    # for iOS
    def select(value)
      find_element.click
      find_option value
    end

    private

    def find_option(option)
      begin
        element = DATPages.driver.wait_for(15) { DATPages.driver.find_element(:value, option)}
        element.click
      rescue
        raise "#{option} was not one of the available options"
      end
    end

  end

end
