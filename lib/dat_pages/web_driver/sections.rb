require_relative 'finders'

class DATPages::WebDriver::PageObjects::Sections

  extend DATPages::WebDriver::PageObjects::Finders

  def self.generate_sections(class_name, locator, parent, find_by)
    sections = []
    parent_element = find_element(parent)
    find_elements(parent_element, locator, find_by).each do |obj|
      sections << class_name.new(obj.path, parent, :xpath)
    end
    sections
  end

end