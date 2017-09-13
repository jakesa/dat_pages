require_relative 'element'

class DATPages::WebDriver::PageObjects::Select < DATPages::WebDriver::PageObjects::Element

  def choose_option(value)
    options = find_elements(self, 'option', :css)
    options.each do |option|
      if option.value == value
        option.select_option
        break
      end
    end
  end

  alias_method :set, :choose_option

  def options
    opts = []
    options = find_elements self, 'option', :css
    options.each do |opt|
      opts << opt.value
    end
    opts
  end



end