module Webpackets
  class Server

    def initialize(options = {})
      @enabled = options.enabled
      @command = options.cmd || './node_modules/.bin/webpack-dev-server'
      @pid = nil
      @semaphore = Mutex.new
    end

    def start
      @semaphore.synchronize do
        return if @pid || !@enabled
        command_options = []
        @pid = Process.spawn @command, *command_options rescue "webpack-dev-server not found"

        at_exit do
          shutdown
        end
      end
    end

    private

    def shutdown
      return if !@pid || !@enabled
      Process.kill "TERM", @pid

      @pid = nil
    end
  end
end
