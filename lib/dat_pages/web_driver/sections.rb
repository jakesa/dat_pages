require 'capybara/dsl'

class DATPages::WebDriver::PageObjects::Sections
  extend Capybara::DSL

  def self.generate_sections(class_name, locator, parent, find_by)
    elements = []
    if find_by == :css || find_by == nil
      locator = xpath(locator)
    end
    find_objects(locator, parent, find_by).each do |obj|
      elements << class_name.new(obj.path, parent, :xpath)
    end
    elements
  end

  private

  def self.xpath(css)
    Nokogiri::CSS.xpath_for(css)[0]
  end


  def self.find_objects(locator, parent = nil, visible = true)
    if !parent.nil? && !parent.locator.nil?
      obj = page.first(:xpath, "#{parent.xpath}", :visible => visible).all(:xpath, "#{locator}", :visible => visible)
    else
      obj = page.all(:xpath, locator, :visible => visible)
    end
    obj
  end


end