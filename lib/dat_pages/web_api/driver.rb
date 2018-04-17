require_relative 'web_api'
module DATPages::WebAPI
  class Driver
    def self.instance
      @instance ||= self.new
    end

    def initialize
      # @session = session
    end
  end


end