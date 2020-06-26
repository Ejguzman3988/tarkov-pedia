class TarkovPedia::Pedia 

    attr_accessor :interest, :name, :process
    @@all = []
    
    def initialize(interest, name)

        @interest = interest
        @name = name
        @process = {}
        grab_processes
        save
    end

    def save
        @@all << self
        
    end
    
    def self.all
        @@all
    end

    #find takes argument of a bool, pedia object.
    def self.find_by_interest_name(interest, name)
        self.all.find{|pedia| pedia.name == name}
    end

    def self.find_or_create_by_interest_name(interest, name)
        obj = self.find_by_interest_name(interest, name)
        if obj.nil?
            obj = self.new(interest, name)
        end

        obj.interest = interest
        obj.name = name

        obj
        
    end

    def list_processes
        @process.keys
    end

    def grab_processes
        # @@processes['descri]ption'
        # @@processes['price']
        #TarkovPedia::Scrapper.find_processes -> List of processes      
        TarkovPedia::Scrapper.find_processes.each{|process| @process[process] = nil} 
    end

    def assign?(process)
        if @process[process] == nil
            @process[process] = TarkovPedia::Scrapper.find_results(self, process) #-> text for that specific process
        else
            puts "Old Result"
            @process[process]
        end
    end
    
    def results(process)

        @process[process]
    end
end