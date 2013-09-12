#!/usr/bin/env ruby
require 'json'

class Engine 
    @@contentFile = 'content.json'
    @@progressFile = 'progress'

    def initialize
        @contentHash = JSON.parse(File.open(@@contentFile).read(), :symbolize_names => true)
        @progress = :origin
        @progress = File.open(@@progressFile).read() if File.exists?(@@progressFile)
        self.scenario
    end

    def scenario
        puts @contentHash[@progress][:description]
        self.analyze gets
    end

    def analyze(action)
        # Check for valid actions
        puts action
    end
end

Engine.new()
