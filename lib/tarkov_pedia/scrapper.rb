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

end