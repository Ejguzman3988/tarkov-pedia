class TarkovPedia::CLI

    def call
        greeting
    end

    def greeting
        puts "What wouuld you like to search?"
        
        puts <<-DOC
            1. Items
            2. Quests
        DOC

        obj = gets.chomp.downcase
    end
end