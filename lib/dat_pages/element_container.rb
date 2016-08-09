

module DATPages

  module ElementContainer

    # valid selector_types = [:id, :xpath, :text]
    def element(name, selector, selector_type=:id)
      if selector_type == :text
        class_eval(%Q(private def #{name.to_s};$driver.find("#{selector}");end))
      else
        class_eval(%Q(private def #{name.to_s};$driver.find_element("#{selector_type}".to_sym, "#{selector}");end))
      end
    end

    def ios_element(name, uielement, value)
      class_eval(%Q(private def #{name.to_s}; $driver.ele_by_json_visible_exact("#{uielement}", "#{value}");end))
    end

    def section(name, class_name)
      class_eval("private def #{name.to_s};@#{name.to_s} ||= #{class_name}.new;end;")
    end

    # note: this will probably change to its own defined method later
    alias_method :page, :section

    # define a button using the value as the locator
    # @param [String] value the value of the button you are looking for
    def button(name, value)
      class_eval(%Q(private def #{name.to_s}; $driver.button("#{value}"); end))
    end


  end


end