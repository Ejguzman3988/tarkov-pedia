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
        
   

    # def name
    #     puts "What is the exact name of the #{user_select.delete_suffix('s')} you wish to search for?"
        
    #     name = gets.chomp.downcase

    # end

    # def process
    #     puts <<-DOC
    #     "Which process would you like to do?"
    #     1. description

    #     2. price
        
    #     3. Back to menu
        
    #     DOC

    #     process = gets.chomp.downcase
    # end 
    
end