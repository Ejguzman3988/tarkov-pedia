class TarkovPedia::Pedia

    attr_accessor :interest, :name, :process
    @@all = []
    def initialize(interest, name)

        @interest = interest
        @name = name
        save
    end

    def save
        @@all << self
    end
    
    def self.all
        @@all
    end

    def results(interest, name, process)
        result = <<-DOC
        The results for #{interest} are below:
        The #{process} for #{name}: 

        Canned beef stew, commonly referred to as tushonka,
        can be stored for years, thus rivaling condensed 
        milk in importance as military and tourist food supply.

        DOC

    end

    #find takes argument of a bool, pedia object.
    def find_by_interest_name(interest, name)
        self.all.find{|pedia| pedia.name == name}
    end

    def find_or_create_by_interest_name(interest, name)
        
        obj = self.find_by_name(name)
        if obj.nil?
            obj = self.new(name)
            save
        end

        obj
        
    end


end