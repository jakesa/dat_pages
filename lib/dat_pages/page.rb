require_relative 'element_container'

module DATPages

  module PageObjects
    class Page
      extend DATPages::ElementContainer
      attr_accessor :selector
      def initialize(selector=nil)
        @selector = selector
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

      def displayed?
        # TODO: there may be a better way to do this
        raise 'The selector property must be set in order to use the #displayed? method' if @selector.nil?
        begin
          return $driver.wait_true(DATPages.config.default_wait_time) { $driver.find_element(:id, @selector).displayed? }
        rescue
          begin
            $driver.wait_true(DATPages.config.default_wait_time) { $driver.find_element(:xpath, @selector).displayed? }
          rescue
            false
          end
        end
      end

    end
  end


end