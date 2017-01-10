require_relative '../../errors'

module DATPages

  module WebDriver::PageObjects::ElementContainer
    # TODO: Throw an error if the driver hasnt been started

    def element(*args)
      args = parse_element_args(args)
      class_eval(%Q(private def #{args[:name].to_s}; @#{args[:name].to_s} ||= DATPages::WebDriver::PageObjects::Element.new("#{args[:locator]}", self, "#{args[:find_by].nil? ? args[:find_by] : args[:find_by].to_sym}");end))
    end

    def section(*args)
      args = parse_section_args args
      class_eval(%Q(private def #{args[:name].to_s};@#{args[:name].to_s} ||= #{args[:class_name]}.new("#{args[:find_by].nil? ? args[:find_by] : args[:find_by].to_sym}");end;))
    end

    # note: this will probably change to its own defined method later
    alias_method :page, :section


    private

    def parse_element_args(args)
      case args.length
        when 2
          {name: args[0], locator: args[1]}
        when 3
          {name: args[0], find_by: args[1], locator: args[2]}
        else
          raise ArgumentError.new("Wrong number of arguments. Expected 2 or 3, got #{args.length}")
      end
    end

    def parse_section_args(args)
      case args.length
        when 2
          {name: args[0], class_name: args[1], locator: args[2]}
        when 3
          {name: args[0], class_name: args[1], find_by: args[2], locator: args[4]}
        else
          raise ArgumentError.new("Wrong number of arguments. Expected 3 or 4, got #{args.length}")
      end
    end

  end


end