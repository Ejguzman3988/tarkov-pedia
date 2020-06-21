class TarkovPedia::CLI

    def call
        
       menu
        
    end

    # returns - string (the interest without the s)
    def list_interests
        #Eventually I want to add more search types, for now I will work with Items only
        # Consider : Changing the name of variables from interest to type later
        list = <<-DOC
        What would you like to search for?
        1. Items
        2. Quests
        DOC
        puts list
        interest = gets.chomp.downcase #Items
        while interest != 'items'
            if interest == 'quests'
                puts "\n\n Funtionality not supported yet. \n Please enter another search query: "
                puts list
                interest = gets.chomp
                
            else
                puts " \n\n Please enter a valid search query: "
                puts list
                interest = gets.chomp
                
            end
        end
        type = interest.delete_suffix('s')
    end


    def name?(type)
        
        puts "What is the exact name of the #{type}?"
        
        name = gets.chomp.downcase


        #REMEMBER: NEED TO ADD FUNTIONALITY TO SCRAPE AND CHECK IF PAGE EXISTS
        while name != 'tushonka'
            puts "\n\nSorry we could not find your #{type}."
            puts "Check the name of the #{type} and try again: "
            name = gets.chomp
        end
        #Pedia.find_or_create_by_name(name)
        #Pedia.list_processes
        name
    end

    def list_process(type, name)

        puts <<-Doc


        #{type} found!
        What would you like to know about #{name}?

        1. description (found on tarkov game pedia)

        2. price (found on tarkov - market)

        Doc

        process = gets.chomp
        #Pedia.find_data(process)
    end

    def menu
        
        #action = Pedia.new(interest)
        interest = list_interests
        name = self.name?(interest)
        list_process(interest, name)
        

        puts <<-DOC
        
        Canned beef stew, commonly referred to as tushonka,
        can be stored for years, thus rivaling condensed 
        milk in importance as military and tourist food supply.

        1. Would you like to search something else?

        2. Back to main menu
        
        3. exit

        DOC

        action = gets.chomp
        #Pedia.exit_back(action)
        


    end
end