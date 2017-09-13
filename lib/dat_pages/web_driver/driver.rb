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
    Capybara.default_max_wait_time = DATPages.config.default_wait_time
  end

  def stop
    @session.driver.quit
  end

  def load_app(clean=true)
    @session.visit('/')
    clear_local_storage if clean
    clear_session_storage if clean
  end

  def load_page(page_object)
    raise "Parameter was not a DATPages::Page" unless page_object.is_a? DATPages::WebDriver::PageObjects::Page
    page_object.load
  end

  def clear_local_storage
    #has to be done after a page has been loaded
    @session.driver.browser.local_storage.clear
  end

  def clear_session_storage
    #has to be done after a page has been loaded
    @session.driver.browser.session_storage.clear
  end



end