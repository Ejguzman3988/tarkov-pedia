class TarkovPedia::Scrapper
    GAMEPEDIA = 'https://escapefromtarkov.gamepedia.com/'
    MARKET = 'https://tarkov-market.com/item/'
    
    attr_accessor :doc, :html

    def self.exist?(name)
        name = name.capitalize().tr(" ", "_")

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
        list = @doc.css('#toc > ul').text.split(' ')
        list.reject{|obj| obj.to_i > 0}
    end

    def self.find_results(process)
        proper_process = process.capitalize()
        processes = TarkovPedia::Pedia.list_processes
        index = processes.find_index(process.capitalize) #index of the process
        start_element = @doc.search("#mw-content-text > div > p")[1]  # Starting element
        
        while index > 0
            if !(start_element.text.include?('[edit | edit source]'))
                start_element = start_element.next_element
            else  
                start_element = start_element.next_element
                index = index - 1
            end  
        end
        results = ''
        
        while !(start_element.text.include?('[edit | edit source]')) && start_element.name != "table"
            
            results << start_element.text
            if !start_element.next_element.nil?
                start_element = start_element.next_element
            else
                break
            end
        end
        results
        
        
        
    end

end