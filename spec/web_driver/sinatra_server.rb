require 'sinatra'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.app_host = 'http://localhost:4567'
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new app, :browser => :chrome
# end
Capybara.current_driver = :selenium_chrome
Selenium::WebDriver::Chrome.driver_path = 'spec/web_driver/driver/chromedriver'

def go_to(url)
  driver = Capybara.current_session
  driver.visit(url)
  driver
end

get '/' do
  erb :test_page
end

class Server

  attr_accessor :server_wait_time
  # TODO: think about how I want this to work with a remote server
  def initialize(report=true, server_wait_time=3)
    @server_wait_time = server_wait_time
    @server_process = nil
    @reporting = report
  end

  def stop
    if @server_process.nil? || @server_process.closed?
      puts 'Server already stopped'
      false
    else
      Process.kill('TERM', @server_process.pid)
      Process.wait2 @server_process.pid
      @server_process = nil
      stop_reporting
      sleep @server_wait_time
      true
    end
  end

  def start
    if @server_process && !@server_process.closed?
      puts 'Server already running'
      false
    else
      @server_process = Object::IO.popen 'ruby ./spec/web_driver/sinatra_server.rb'
      sleep @server_wait_time
      start_reporting
      true
    end

  end

  def status
    if @server_process && !@server_process.closed?
      'running'
    else
      'stopped'
    end
  end

  private

  #TODO - possible resource conflict, not thread safe?
  def start_reporting
    @reporting = Thread.new {
      while @report
        puts @server_process.readlines
      end
    }
  end

  def stop_reporting
    @reporting.kill
    @reporting = nil
  end


end