require_relative 'element_container'

module DATPages

  module PageObjects
    class Page
      extend DATPages::ElementContainer

      def initialize
        @driver = $driver
      end

      # method for catching exceptions
      # @return [Boolean] will return true if the code did not raise an error, false if it did. It will also print the error and backtrace of the error
      def validate(&block)
        begin
          yield
          return true
        rescue => e
          puts e
          puts e.backtrace
          return false
        end
      end


    end
  end


end