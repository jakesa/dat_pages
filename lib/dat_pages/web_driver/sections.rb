# require 'capybara/dsl'
require_relative 'finders'

class DATPages::WebDriver::PageObjects::Sections
  # extend Capybara::DSL
  extend DATPages::WebDriver::PageObjects::Finders

  def self.generate_sections(class_name, locator, parent, find_by)
    elements = []
    # if find_by == :css || find_by == nil
    #   locator = xpath(locator)
    # end
    parent_element = find_element(parent)
    find_elements(parent_element, locator, find_by).each do |obj|
      elements << class_name.new(obj.path, parent, :xpath)
    end
    elements
  end

  private

  # def self.xpath(css)
  #   Nokogiri::CSS.xpath_for(css)[0]
  # end


  #TODO: Need to move finding objects to its own moduel and need to add error checks.
  # One specifically for the case where the parent class doesnt find any elements. It throws undefined method 'all' for nil class
  # def self.find_objects(locator, parent = nil, visible = true)
  #   if !parent.nil? && !parent.locator.nil?
  #     obj = page.first(:xpath, "#{parent.xpath}", :visible => visible).all(:xpath, "#{locator}", :visible => visible)
  #   else
  #     obj = page.all(:xpath, locator, :visible => visible)
  #   end
  #   obj
  # end


end