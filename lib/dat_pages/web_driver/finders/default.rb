require 'capybara/dsl'
require_relative '../../errors'
module DATPages::WebDriver::PageObjects::Finders::Default
  include Capybara::DSL

  # find an element using all of its parent elements
  def find_element(obj, prev_obj=nil, wait=Capybara.default_max_wait_time)
    begin
      if obj.find_by == :xpath
        if prev_obj != nil && prev_obj.locator != nil
          @element = prev_obj.native.find(:xpath, obj.locator)
        else
          @element = page.find(:xpath, obj.locator)
        end
      elsif obj.find_by == :id
        @element = page.find(:id, obj.locator)
      else
        if prev_obj != nil && prev_obj.locator != nil
          if obj.locator.include? '#'
            # puts "Finding: #{obj.locator}"
            @element = page.find(obj.locator, {wait: wait})
          else
            # puts "Finding: #{obj.locator}"
            @element = prev_obj.native.find(obj.locator, {wait: wait})
          end
        else
          # puts "Finding: #{obj.locator}"
          @element = page.find(obj.locator, {wait: wait})
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
