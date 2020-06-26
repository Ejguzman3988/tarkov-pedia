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
        puts <<-DOC.gsub /^\s*/, ''
        Welcome to your Escape from Tarkov gamepedia. 
        All information used on this program was derived from:
        https://escapefromtarkov.gamepedia.com/
        https://tarkov-market.com/
        DOC
        puts "------------------------------------------"
        puts "Type 'exit' at anytime to exit.\n\n"

    end  

    #Handles user Inputs
    def menu
        
        #displays list of possible interest (items, quests, etc)
        interest = list_interests
        system('clear')
        
        
        #Asks user for the name of their interest
        name = self.name?(interest)
        system('clear')
        
        
        
        pedia = TarkovPedia::Pedia.find_or_create_by_interest_name(interest, name) #creates Pedia Obj
        process = self.display_processes(pedia) 
        
        
        
        system('clear')
        puts "------------------------------------------\n"
        display_results(pedia, process)
        puts "------------------------------------------\n"
        
        
        action?(pedia, process)

        
    end

    # returns - string (the interest without the s)
    def list_interests
        
        list = <<-DOC.gsub /^\s*/, ''
        1. Items
        2. Quests
        DOC
        
        puts list
        puts "\n\nWhat would you like to search for?".bold
        interest = gets.chomp.downcase #Items
        exit?(interest)
        #Checks input from user

        while interest != 'items'
            if interest == 'quests'
                system('clear')
                puts "Funtionality not supported yet. \nPlease enter another search query: ".bold
                puts list
                puts "\n\nWhat would you like to search for?".bold
                interest = gets.chomp.downcase
                exit?(interest)
            else
                system('clear')
                puts "Please enter a valid search query: ".bold
                puts list
                puts "\n\nWhat would you like to search for?".bold
                interest = gets.chomp.downcase
                exit?(interest)
            end
        end
        type = interest.delete_suffix('s')
    end

    def name?(type)
        exact = "EXACT".underline
        puts "\nWhat is the #{exact} name of the #{type} you are interested in today?"
        
        name = gets.chomp
        exit?(name)
        #REMEMBER: NEED TO ADD FUNTIONALITY TO SCRAPE AND CHECK IF PAGE EXISTS
        while !TarkovPedia::Scrapper.exist?(name)
            system('clear')
            puts "Sorry we could not find your #{type}.".bold
            puts "Check the name of the #{type} and try again.".bold
            puts "\nWhat is the exact name of the #{type} you are interested in today?"
            name = gets.chomp
            exit?(name)
        end
        name
    end

    def list_processes(pedia)
        list = pedia.list_processes
        price_index = list.length+1
        #lists processes starting with price. (Price isn't in GAME PEDIA)
        list.each_with_index do |process,index|
            if have_period?(process)
                price_index -= 1
                puts " #{process}".italic
            else 
                puts process
            end
        end
        puts "#{price_index} Price"
        puts "\n\nWhat would you like to search for concerning #{pedia.name}?".bold
        list
    end
    
    #takes a string, returns bool if it has a period.
    def have_period?(string)
        return true if string.include?(".")
        false
    end
    
    def display_processes(pedia)   
        list = list_processes(pedia).collect{|process| process.downcase}
        process = gets.chomp.downcase
        exit?(process)
        
        while !input_correct?(pedia, list, process)
            if process == 'price'
                system('clear')
                puts "\n\nFunctionality not supported yet.\nPlease enter another process ".bold
                list_processes(pedia)
                process = gets.chomp.downcase
                exit?(process)
            else
                system('clear')
                puts "Please enter a valid process.".bold
                list_processes(pedia)

                process = gets.chomp.downcase
                exit?(process)
            end
        end
        process
    end

    def input_correct?(pedia, list, process)
        list.each{|item| return true if item.split(/\d+ /)[1] == process}
        false
    end

    def display_results(pedia, process)
        interest = pedia.interest
        name = pedia.name
        puts "The #{process} of your #{interest} search, #{name}:".underline
        puts "\n\n"
        pedia.assign?(process)
        puts pedia.results(process)
    end

    def action?(pedia,process)
        
        
        list = <<-DOC.gsub /^\s*/, ''
        
        1. To go back type 'back'

        2. To go to main menu type 'main'
        
        3. To exit type 'exit'
        
        DOC
        puts list
        action = gets.chomp.downcase
        interest = pedia.interest
        name = pedia.name
        
        if action == 'back'
            system('clear')            
            process = self.display_processes(pedia) 
            system('clear')
            puts "------------------------------------------"
            display_results(pedia, process)
            puts "------------------------------------------"
            action?(pedia, process)
            puts "------------------------------------------"

        elsif action  == 'main'
            system('clear')
            menu
        elsif action == 'exit'
            close
        else
            system('clear')
            puts "Action not recognize, please try again.".bold
            action?(pedia, process)
        end
    end

    def close
        index = 3
        while index > -1
            system('clear')
            puts "Thank you for using this product."
            puts "Goodbye!"
            puts index
            sleep(1)
            index -= 1
        end
        system('clear')
        exit
        
    end

    def exit?(input)
        if input == 'exit'
            close
        end
    end
end