require 'capybara'
require 'capybara/dsl'
require_relative '../errors'
require_relative 'web_driver'

class DATPages::WebDriver::Driver

  include Capybara::DSL

  def self.instance
    @instance ||= self.new
  end

  def initialize(session=Capybara.current_session)
    @session = session
  end

  def stop
    @session.driver.quit
  end

  def load_app
    @session.visit('/')
  end

  def load_page(page_object)
    raise "Parameter was not a DATPages::Page" unless page_object.is_a? DATPages::WebDriver::PageObjects::Page
    page_object.load
  end



end