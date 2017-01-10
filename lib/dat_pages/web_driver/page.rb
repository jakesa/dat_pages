require_relative 'elements/element_container'
require_relative 'elements/element'

class DATPages::WebDriver::PageObjects::Page < DATPages::WebDriver::PageObjects::Element

  include Capybara::DSL

  extend DATPages::WebDriver::PageObjects::ElementContainer

  def initialize(url=nil)
    @url = url ? (Capybara.app_host + url) : nil
    super(nil)
  end

  def load
    Capybara.current_session.visit @url unless @url.nil?
  end

end
