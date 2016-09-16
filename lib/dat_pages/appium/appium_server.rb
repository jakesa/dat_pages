
require 'pry'
module DATPages
  module Appium
    class AppiumServer
      attr_accessor :server_wait_time
      # TODO: think about how I want this to work with a remote server
      def initialize(report = false, server_wait_time=3)
        @server_wait_time = server_wait_time
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
          sleep @server_wait_time
          true
        end
      end

      def start
        if @server_process && !@server_process.closed?
          puts 'Server already running'
          false
        else
          @server_process = Object::IO.popen "appium"
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
end