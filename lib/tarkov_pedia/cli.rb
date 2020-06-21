class TarkovPedia::CLI

    def call
        
       menu
        
    end

    def menu
        puts <<-DOC
        What would you like to search for?
        1. Items
        2. Quests
        DOC

        interest = gets.chomp.downcase
        #action = Pedia.new(interest)
        
        puts "What is the exact name of the #{interest.delete_suffix('s')}?"
        
        name = gets.chomp
        #Pedia.find_or_create_by_name(name)
        #Pedia.list_processes

        puts <<-Doc
        1. description (found on tarkov game pedia)

        2. price (found on tarkov - market)

        Doc

        process = gets.chomp
        #Pedia.find_data(process)

        puts <<-DOC
        
        Canned beef stew, commonly referred to as tushonka,
        can be stored for years, thus rivaling condensed 
        milk in importance as military and tourist food supply.

        1. Would you like to search something else?

        2. Back to main menu

        DOC

        action = gets.chomp
        #Pedia.exit_back(action)
        


    end
end