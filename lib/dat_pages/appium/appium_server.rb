
require 'pry'
require 'timeout'

module DATPages
  module Appium
    class AppiumServer
      attr_accessor :server_wait_time
      # TODO: think about how I want this to work with a remote server
      def initialize(report = false, server_wait_time=3)
        @server_wait_time = server_wait_time
        @report = report
        @appium_port = DATPages.config.appium_port
        @emulator_port = DATPages.config.emulator_port
        @bootstrap_port = DATPages.config.bootstrap_port
      end

      def stop
        if @server
          _process.nil? || @server_process.closed?
          puts 'Server already stopped'
          false
        else
          Process.kill(9, @server_process.pid)
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
          @server_process = Object::IO.popen "appium -p #{@appium_port ? @appium_port : '4723'} -bp #{@bootstrap_port ? @bootstrap_port : '5800'} -U emulator-#{@emulator_port ? @emulator_port : '5554'}"
          start_reporting
          raise 'There was a problem starting appium server' if wait_for_startup == false
          true
        end

      end

      def wait_for_startup
        wait_for(30){
          output = @server_process.gets
          puts output
          output.include?('Appium REST http interface listener started')
        }
      end

      def wait_for(timeout = DATPages.config.default_wait_time, &block)
        require 'timeout'
        raise 'Need a block' unless block_given?
        begin
          Timeout::timeout(timeout){
            loop do
              value = yield
              return true if value
            end
          }
        rescue
          return false
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
        @reporting.kill unless @reporting.nil?
        @reporting = nil
      end


    end
  end
end