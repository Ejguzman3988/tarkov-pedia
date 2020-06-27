class TarkovPedia::Scrapper
    GAMEPEDIA = 'https://escapefromtarkov.gamepedia.com/' 
    MARKET = 'https://tarkov-market.com/item/' #Used to find Price
    
    attr_accessor :doc, :html

    # Formats url by add the name replacing spaces with underscore then checks if url_exists
    # 
    # @param name [String] the name of insterest, 'bitcoin','Dorm room 108 Key', 'Tushonka',etc
    # @return [Bool] returns true if the url exists
    def self.exist?(name)
        name = name.tr(" ", "_")
        url = GAMEPEDIA + name
        
        url_exist?(url)
        
    end
    
    # Uses nokogori to store HTML. It rescues exception raised by nokogiri and returns false
    # 
    # @param url [String] the url after adding their input 'https://escapefromtarkov.gamepedia.com/bitcoin' 
    # @return [html] returns html obj if url exists or false if it doesn't
    def self.url_exist?(url)
        begin
            @html = open(url)
            @doc = Nokogiri::HTML(@html)
        
            #checks if the input is an INTEREST
            heading = @doc.search("#firstHeading").text
            if @doc.search("#mw-panel").text.include?(heading) #compairs the input with the side panel on website
                false
            else
                @doc
            end
        rescue => exception  # If the url doesn't exist stops nokogiri from raising error
            
            false
        end
    end

    # Looks through the html document and finds the process from the table of contents
    # 
    # @return [array] returns an array of strings containing the processes of the item
    def self.find_processes
          
        processes = {}
        list = @doc.css('h2 span.mw-headline').map do |process_element|
            elements = []
            el = process_element.parent.next_element
            while el && el.name != 'h2'
                elements << el
                el = el.next_element
            end
        
            processes[process_element.text] = elements.map{|e| e.text}.join(' ')
        end
        processes
    end

    # Uses nokogori to store HTML. It rescues exception raised by nokogiri and returns false
    # 
    # @param pedia, process [Pedia, String] Uses a pedia obj to acess its functions and also a string representing a process
    # @return [String] in the variable results it returns a string of the results for the process inputted.    
    def self.find_results(pedia, process)
        
        processes = pedia.list_processes # grabs all the processes in a list
        pedia.format_list(processes)
        binding.pry
        index = processes.find_index(pedia.find_process_name(process, processes))+1 # index of the process inside the list of processes
        start_element = @doc.search("#mw-content-text > div > p")[1]  # The first process on the html page
        
        # starts at the first element and moves down until it finds the element we are interested in
        while index > 1
            # Checking if element is currently a drop down box at the end of the page.
            if !(start_element.attributes['class'].nil?) && start_element.attributes['class'].value.include?('va-navbox')
                break
            elsif !(start_element.text.include?('[edit | edit source]')) # Checks the Header
                start_element = start_element.next_element
                
            else 
                start_element = start_element.next_element
                index = index - 1
            end  
        end
        
        results = '' #where we will store our results
       
        # Continues until it reaches another section
        while !(start_element.text.include?('[edit | edit source]'))
            # Checking if element is currently a drop down box at the end of the page.
            if !(start_element.attributes['class'].nil?) && start_element.attributes['class'].value.include?('va-navbox')
                break
            elsif
                results << start_element.text
            end

            # Checks if the next element is empty
            if !start_element.next_element.nil?
                start_element = start_element.next_element
            else
                break
            end
        end
       
        results
    end

end