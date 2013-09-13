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
        action = action.downcase.tr(" ", "_").tr("\n", "").to_sym
        if action == :look
            self.scenario
        elsif @contentHash[@progress].key?(action)
            event = @contentHash[@progress][action] 
            if event.is_a?(Hash)
                puts event[:description]
                @progress = event[:next].to_sym
                self.scenario
            else
                puts event
            end
        else
            puts @contentHash[:dont_understand]
        end
    end
end

Engine.new()
