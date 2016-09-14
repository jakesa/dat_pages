require_relative 'elements/element_container'

module DATPages

  module PageObjects

    class Section
      extend DATPages::ElementContainer

      attr_accessor :selector
      def initialize(selector=nil)
        @selector = selector
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