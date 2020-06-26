class TarkovPedia::CLI 

    def call
        system('clear')
        #greets User
        greeting
        #Displays Menu
        menu
        
    end
    
    #greets User
    def greeting
        puts <<-DOC
        Welcome to your Escape from Tarkov gamepedia. 
        All information used on this program was derived from:
        https://escapefromtarkov.gamepedia.com/
        https://tarkov-market.com/


        DOC
    end  

    #Handles user Inputs
    def menu
        puts "------------------------------------------"
        
        
        #displays list of possible interest (items, quests, etc)
        interest = list_interests
        system('clear')
        
        
        #Asks user for the name of their interest
        name = self.name?(interest)
        system('clear')
        
        
        
        pedia = TarkovPedia::Pedia.find_or_create_by_interest_name(interest, name) #creates Pedia Obj
        process = self.display_processes(pedia) 
        
        
        
        puts "------------------------------------------"
        display_results(pedia, process)
        
        
        puts "------------------------------------------"
        
        
        action?(pedia, process)
        puts "------------------------------------------"
        
    end

    # returns - string (the interest without the s)
    def list_interests
        
        list = <<-DOC



        1. Items
        2. Quests


        What would you like to search for?
        DOC
        
        puts list
        interest = gets.chomp.downcase #Items
        
        #Checks input from user

        while interest != 'items'
            if interest == 'quests'
                system('clear')
                puts "\n\n Funtionality not supported yet. \n Please enter another search query: "
                puts list
                interest = gets.chomp.downcase
                
            else
                system('clear')
                puts " \n\n Please enter a valid search query: "
                puts list
                interest = gets.chomp.downcase
                
            end
        end
        type = interest.delete_suffix('s')
    end

    def name?(type)
        
        puts "\nWhat is the exact name of the #{type} you are interested in today?"
        
        name = gets.chomp


        #REMEMBER: NEED TO ADD FUNTIONALITY TO SCRAPE AND CHECK IF PAGE EXISTS
        while !TarkovPedia::Scrapper.exist?(name)
            puts "------------------------------------------"
            puts "\n\nSorry we could not find your #{type}."
            puts "Check the name of the #{type} and try again: "
            name = gets.chomp
            
        end
        name
    end

    def list_processes(pedia)
        list = pedia.list_processes
        puts "\n"
        
        #lists processes starting with price. (Price isn't in GAME PEDIA)
        list.each_with_index do |process, i|
            if i == 0
                puts "#{i+1}. Price \n#{i+2}. #{process}"
            else
                puts "#{i+2}. #{process} "
            end
        end
        puts "\n\nWhat would you like to search for concerning #{pedia.name}?"
        list
    end
    
    def display_processes(pedia)
        list = list_processes(pedia).collect{|process| process.downcase}
        process = gets.chomp.downcase
        
        
        while !list.include?(process)
            if process == 'price'
                puts "------------------------------------------"
                puts "\n\nFunctionality not supported yet.\nPlease enter another process "
                list_processes(pedia)
                process = gets.chomp.downcase
            else
                puts "------------------------------------------"
                puts "\n\nPlease enter a valid process."
                list_processes(pedia)

                process = gets.chomp.downcase
            end
        end
        process
    end

    def display_results(pedia, process)
        interest = pedia.interest
        name = pedia.name
        pedia.assign?(process)
        puts pedia.results(process)
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
        
        if action == 'back'
            process = self.display_processes(pedia) 
            puts "------------------------------------------"
            display_results(pedia, process)
            puts "------------------------------------------"
            action?(pedia, process)
            puts "------------------------------------------"

        elsif action  == 'main'
            menu
        elsif action == 'exit'
            puts "Your search for the #{process} of the #{pedia.interest}, #{pedia.name}, is complete."
            puts "Thank you for using this product."
            puts "Goodbye!"
            sleep(3)
        else
            puts "Action not recognize, please try again."
            action?(pedia, process)
        end
    end
end