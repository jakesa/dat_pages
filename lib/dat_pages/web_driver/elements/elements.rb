require_relative 'element'
require_relative '../finders'

class DATPages::WebDriver::PageObjects::Elements

  extend DATPages::WebDriver::PageObjects::Finders

  def self.generate_elements(locator, parent_element, find_by)
    elements = []
    parent = find_element parent_element
    find_elements(parent, locator, find_by).each do |element|
      elements << DATPages::WebDriver::PageObjects::Element.new(element.path, parent_element, :xpath)
    end
    elements
  end

  def self.xpath(css)
    Nokogiri::CSS.xpath_for(css)[0]
  end

  private

  # JS - this is not used but I am keeping it here for reference. I have a feeling I am going to modify the Finder at a later date
  def self.find_objects(locator, parent = nil, visible = true)
    if !parent.nil? && !parent.locator.nil?
      obj = page.first(:xpath, "#{parent.xpath}", :visible => visible).all(:xpath, ".#{locator}", :visible => visible)
    else
      obj = page.all(:xpath, locator, :visible => visible)
    end
    obj
  end



end