
module DATPages
  module Errors
    class ElementNotFound < StandardError
      def initialize(locator=nil)
        if locator.nil?
          str = "Unable to find element."
        else
          str = "Unable to find element with #{locator}."
        end
        super str
      end
    end #ElementNotFound

    class ElementVisible < StandardError
      def initialize(locator=nil)
        if locator.nil?
          str = 'Element remained visible.'
        else
          str = "Element with selector #{locator} remained visible."
        end
        super str
      end
    end #ElementVisible

    class ElementNotVisible < StandardError
      def initialize(locator=nil)
        if locator.nil?
          str = 'Element was not visible.'
        else
          str = "Element with selector #{locator} was not visible."
        end
        super str
      end
    end #ElementNotVisible

  end #Errors
end #DATPages