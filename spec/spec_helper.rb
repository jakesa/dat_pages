require 'capybara/dsl'
require_relative '../lib/dat_pages'
require_relative '../lib/dat_pages/appium/appium_server'

# Common
require_relative '../lib/dat_pages/capabilities'
require_relative '../lib/dat_pages/driver_connection'

# WebDriver
require_relative 'web_driver/sinatra_server'
require_relative '../lib/dat_pages/web_driver/page'
require_relative '../lib/dat_pages/web_driver/elements/element_container'
require_relative '../lib/dat_pages/web_driver/section'
require_relative '../lib/dat_pages/web_driver/elements/element'

# Appium
require_relative '../lib/dat_pages/appium/page'
require_relative '../lib/dat_pages/appium/elements/element_container'
require_relative '../lib/dat_pages/appium/section'
require_relative '../lib/dat_pages/appium/driver'
require_relative '../lib/dat_pages/appium/elements/element'





