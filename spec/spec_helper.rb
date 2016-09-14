require_relative 'sinatra_server'
require 'capybara/dsl'
require_relative '../lib/dat_pages'
require_relative '../lib/dat_pages/capabilities'
require_relative '../lib/dat_pages/page'
require_relative '../lib/dat_pages/elements/element_container'
require_relative '../lib/dat_pages/section'
require_relative '../lib/dat_pages/appium/driver'
require_relative '../lib/dat_pages/appium/element'
require_relative '../lib/dat_pages/driver_connection'
require_relative '../lib/dat_pages/web_driver/element'

Capybara.app_host = 'http://localhost:4567'
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new app, :browser => :firefox
end
Capybara.default_driver = :selenium

def go_to(url)
  driver = Capybara.current_session
  driver.visit(url)
  driver
end

