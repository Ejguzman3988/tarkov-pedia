class TarkovPedia::CLI

    def call
        interest
        
        
    end

    
        
    def interest
        puts <<-DOC
        1. Items
        2. Quests
        DOC

        interest = gets.chomp.downcase
        interest
    end

    def name
        puts "What is the exact name of the #{user_select.delete_suffix('s')} you wish to search for?"
        
        name = gets.chomp.downcase

    end

    def process
            puts "Which process would you like to do?"

        puts <<-DOC
        
        1. description

        2. price
        
        3. Back to menu
        
        DOC

        process = gets.chomp.downcase
    end 
    
end