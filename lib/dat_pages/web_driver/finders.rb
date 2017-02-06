require 'capybara/dsl'
require_relative '../errors'
module DATPages::WebDriver::PageObjects::Finders
  include Capybara::DSL


  # find an element using all of its parent elements
  def find_element(obj, prev_obj=nil)
    begin
      if obj.find_by == :xpath && obj.locator.include?('html')
        @element = page.find(:xpath, obj.locator, :visible => true)
      elsif obj.parent_element != nil && obj.parent_element.locator != nil
        @element = find_element(obj.parent_element, obj)
      else
        if obj.find_by == :css && obj.locator.include?('#')
          @element = page.find(:id, obj.locator.gsub('#', ''), :visible => true)
        else
          @element = page.find(obj.find_by, obj.locator, :visible => true)
        end
      end
      #TODO: There may be a flaw in this logic. Need to come back and review at some point
      if prev_obj
        if prev_obj.find_by == :css && prev_obj.locator.include?('#')
          @element = page.find(:id, prev_obj.locator.gsub('#', ''), :visible => true)
        else
          @element = @element.find(prev_obj.find_by, prev_obj.locator, :visible => true)
        end

      end
    rescue
      raise DATPages::Errors::ElementNotFound.new(obj.locator)
    end
    @element
  end

  def find_elements(parent_element, locator, find_by)
    find_by = :css if find_by.nil?
    parent_element.all find_by, locator, :visible => true
  end


end
