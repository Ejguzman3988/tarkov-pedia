class TarkovPedia::CLI

    def call
        menu
        
    end

    def menu
        puts "What wouuld you like to search?"
        
        puts <<-DOC
            1. Items
            2. Quests
        DOC

        user_select = gets.chomp.downcase

        puts "What is the exact name of the #{user_select.delete_suffix('s')} you wish to search for?"
        user_type = gets.chomp.downcase
        puts "Which process would you like to do?"

        puts <<-DOC
        
        1. description

        2. price
        
        3. go back to menu 
        
        DOC

        user_search = gets.chomp.downcase
    end


    
end