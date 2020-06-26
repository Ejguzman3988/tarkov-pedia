class TarkovPedia::Scrapper
    GAMEPEDIA = 'https://escapefromtarkov.gamepedia.com/'
    MARKET = 'https://tarkov-market.com/item/'
    
    attr_accessor :doc, :html

    def self.exist?(name)
    
        #ENCAPSULATE INTO ITS ON FUNCTION CALLED CASES
        name = name.capitalize if !(name =~ /[A-Z]{2}/) #Fixes issue with having more than 2 capitalization
        
        #Fixes issue with numbers in the middle of a string, prompting the need to capitalize the next word.
        name = name.split(/(\d+) /) if !(name.split(/(\d+) /).nil?) #checks if string contains a number
        
        
        name.each_with_index do |part, index|
            
            #capitalizes the word after the number
            if (part.to_i > 0 && index != name.length)
                name[index+1] = name[index+1].capitalize
                name[index] = name[index] + " "
            end
        end
        name = name.join()

        
        name = name.tr(" ", "_")
        url = GAMEPEDIA + name
        
        url_exist?(url)
        
    end
    #takes arg of name, returns array of different cases
    def cases(name)
        #checks if Dorm key - Key is captilized after number
        #checks if Shoreline key - key is not capitilized
        #checks if More than 1 of the first letters is capitalized
        
    end

    def self.url_exist?(url)
        begin
            @html = open(url)
            @doc = Nokogiri::HTML(@html)
            
        rescue => exception
            
            false
        end
    end

    #new class method self.find_processes that looks through the scrapped page and returns a list of processes
    def self.find_processes
          
            
        list = @doc.css('#toc > ul').text.downcase.split("\n").join().split(/(\d+) /)
        list = list.reject{|obj| obj.to_i > 0}
        list.reject{|obj| obj == ''}
        
    end

    def self.find_results(process)
     
        
        processes = TarkovPedia::Pedia.list_processes
        index = processes.find_index(process)+1 #index of the process
        start_element = @doc.search("#mw-content-text > div > p")[1]  # Starting element
        
        
        while index > 1
            if !(start_element.attributes['class'].nil?) && start_element.attributes['class'].value.include?('va-navbox')
                break
            elsif !(start_element.text.include?('[edit | edit source]'))
                start_element = start_element.next_element
                
            else  
                start_element = start_element.next_element
                index = index - 1
            end  
        end
        
        results = ''
       
        while !(start_element.text.include?('[edit | edit source]'))
            #checking if element is currently a drop down box.
            if !(start_element.attributes['class'].nil?) && start_element.attributes['class'].value.include?('va-navbox')
                break
            elsif
                results << start_element.text
            end

            if !start_element.next_element.nil?
                start_element = start_element.next_element
            else
                break
            end
        end
       
        results
    end

end