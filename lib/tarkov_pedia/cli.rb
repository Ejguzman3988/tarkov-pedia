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
                interest = gets.chomp.downcase
                
            else
                puts " \n\n Please enter a valid search query: "
                puts list
                interest = gets.chomp.downcase
                
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
            name = gets.chomp.downcase
        end
        #Pedia.find_or_create_by_name(name)
        #Pedia.list_processes
        name
    end

    def list_processes(type, name)
        puts "#{type} found!"
        list = <<-Doc
        What would you like to know about #{name}?

        1. Description 

        2. Price

        Doc

        puts list

        process = gets.chomp.downcase
        #Pedia.find_data(process)

        while process != 'description'
            if process == 'price'
                puts "\n\nFunctionality not supported yet.\nPlease enter another process "
                puts list
                process = gets.chomp.downcase\
            else
                puts "\n\nPlease enter a valid process."
                puts list

                process = gets.chomp.downcase
            end
            

        end
    end

    def results(interest, name, process)
        puts <<-DOC
        The results for #{interest} are below:
        The #{process} for #{name}: 

        Canned beef stew, commonly referred to as tushonka,
        can be stored for years, thus rivaling condensed 
        milk in importance as military and tourist food supply.

        DOC

    end

    def action?(interest, name)
        list = <<-DOC
        
        1. To go back type 'back'

        2. To go to main menu type 'main'
        
        3. To exit type 'exit'
        
        DOC

        puts list
        action = gets.chomp.downcase
        
        if action == 'back'
            process = list_processes(interest, name)
            results(interest, name, process)
            action?(interest,name)

        elsif action  == 'main'
            menu
        elsif action == 'exit'
            puts "Thank you for using this product."
            puts "Goodbye!"
            sleep(3)
        else
            puts "Action not recognize, please try again."
            action?(interest,name)
        end
    end

    def menu
        
        #action = Pedia.new(interest)
        interest = list_interests
        name = self.name?(interest)
        process = self.list_processes(interest, name)
        results(interest, name, process)
        action?(interest, name)


       
        

    end
end