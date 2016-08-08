require_relative '../../lib/dat_pages'
require 'pry'
module DATPages

  class AppiumServer

    # TODO: think about how I want this to work with a remote server
    def initialize(_start = true, report = false)
      if _start == true
        start
        start_reporting
      end
      @report = report
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
        sleep 2
        true
      end
    end

    def start
      if @server_process && !@server_process.closed?
        puts 'Server already running'
        false
      else
        @server_process = Object::IO.popen "appium"
        sleep 2
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
          puts @server_process.readline
        end
      }
    end

    def stop_reporting
      @reporting.kill
      @reporting = nil
    end


  end

end