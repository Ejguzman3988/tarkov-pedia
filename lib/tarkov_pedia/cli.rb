class TarkovPedia::CLI

    def call
        
        TarkovPedia::Interest.new(greeting)
        
        
    end

    def greeting
        puts <<-DOC
        What would you like to search for?
        1. Items
        2. Quests
        DOC

        interest = gets.chomp.downcase
        interest
    end
end