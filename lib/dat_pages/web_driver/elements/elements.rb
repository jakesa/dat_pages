require_relative 'element'
require 'capybara'
require 'capybara/dsl'
require_relative '../../errors'

class DATPages::WebDriver::PageObjects::Elements

  include Capybara::DSL

  attr_reader :parent, :locator, :find_by, :elements

  def initialize(locator, parent=nil, find_by=:css)
    @parent  = parent
    if locator.is_a? String
      if locator.empty?
        @locator = nil
      else
        @locator = locator
      end
    else
      @locator = locator
    end
    @elements = []
    @find_by = find_by.nil? ? :css : find_by.to_sym
    get_elements self.xpath, parent

  end

  def xpath
    if @find_by == :css && @locator != nil
      Nokogiri::CSS.xpath_for(@locator)[0]
    else
      @locator
    end
  end

  private

  def get_elements(locator, parent)
    find_objects(locator, parent).each do |obj|
      @elements << DATPages::WebDriver::PageObjects::Element.new(obj.path, parent, :xpath)
    end
  end

  def find_objects(locator, parent = nil, visible = true)
    if !parent.nil? && !parent.locator.nil?
      obj = page.first(:xpath, "#{parent.xpath}", :visible => visible).all(:xpath, "#{locator}", :visible => visible)
    else
      obj = page.all(:xpath, locator, :visible => visible)
    end
    obj
  end



end