class TarkovPedia::Scrapper
    GAMEPEDIA = 'https://escapefromtarkov.gamepedia.com/'
    MARKET = 'https://tarkov-market.com/item/'
    
    attr_accessor :doc, :html

    def self.exist?(name)
        name = name.tr(" ", "_")
        url = GAMEPEDIA + name
        
        url_exist?(url)
        
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
          
         
        list = @doc.css('#toc > ul').text.split("\n").reject{|obj| obj == ""}
        
    end

    def self.find_results(pedia, process)
        
        processes = pedia.list_processes.join().split(/\d+/).join.downcase.split(".").join().split(" ")
        #Processes array of processes getting rid of numbers, periods, and spaces, as well as downcasing.
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