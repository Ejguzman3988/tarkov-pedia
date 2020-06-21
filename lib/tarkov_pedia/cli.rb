class TarkovPedia::CLI 

    def call
        
       menu
        
    end
    
    def menu
        
        interest = list_interests
        name = self.name?(interest)
        pedia = TarkovPedia::Pedia.find_or_create_by_interest_name(interest, name) #creates Pedia Obj
        process = self.list_processes(pedia) 
        display_results(pedia, process)
        action?(pedia, process)
    end

    # returns - string (the interest without the s)
    def list_interests
        
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
        while !TarkovPedia::Scrapper.exist?(name)
            puts "\n\nSorry we could not find your #{type}."
            puts "Check the name of the #{type} and try again: "
            name = gets.chomp.downcase
        end
        name
    end

    def list_processes(pedia)

        puts TarkovPedia::Pedia.list_processes

        process = gets.chomp.downcase
        

        while process != 'description'
            if process == 'price'
                puts "\n\nFunctionality not supported yet.\nPlease enter another process "
                puts list
                process = gets.chomp.downcase
            else
                puts "\n\nPlease enter a valid process."
                puts list

                process = gets.chomp.downcase
            end
            

        end
        
        process = process.delete_suffix('s')
    end


    def action?(pedia,process)
        
        
        list = <<-DOC
        
        1. To go back type 'back'

        2. To go to main menu type 'main'
        
        3. To exit type 'exit'
        
        DOC
        puts list
        action = gets.chomp.downcase

        interest = pedia.interest
        name = pedia.name
        process = pedia.process
        
        if action == 'back'
            process = list_processes(interest, name)
            action?(pedia, process)

        elsif action  == 'main'
            menu
        elsif action == 'exit'
            puts "Your search for the #{pedia.process} of the #{pedia.interest}, #{pedia.name}, is complete."
            puts "Thank you for using this product."
            puts "Goodbye!"
            sleep(3)
        else
            puts "Action not recognize, please try again."
            action?(pedia, process)
        end
    end

    def display_results(pedia, process)
        interest = pedia.interest
        name = pedia.name
        pedia.assign?(process)
        puts pedia.results
    end
end