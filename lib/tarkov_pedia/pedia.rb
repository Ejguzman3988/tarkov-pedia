class TarkovPedia::Pedia 

    attr_accessor :interest, :name, :process
    @@all = []
    @@processes = []
    def initialize(interest, name)

        @interest = interest
        @name = name
        grab_processes
        save
    end

    def save
        @@all << self
    end
    
    def self.all
        @@all
    end

    def results

        self.process
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

    def self.list_processes
        @@processes
    end

    def grab_processes
        @@processes << 'description'
        @@processes << 'price'

    end

    def assign?(process)
        if @process.nil?
            @process = <<-DOC
        The results for #{self.interest} are below!
        The #{process} for #{self.name} is: 
    
        Canned beef stew, commonly referred to as tushonka,
        can be stored for years, thus rivaling condensed 
        milk in importance as military and tourist food supply.

            DOC
            
        else
            puts "Old Result"
            @process
        end
    end


end