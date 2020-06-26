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
        actual_process = find_process_name(process)
        #binding.pry
        if @process[actual_process] == nil
            @process[actual_process] = TarkovPedia::Scrapper.find_results(self, process) #-> text for that specific process
        else
            puts "Old Result"
            @process[actual_process]
        end
    end

    def format_list(list)
        keys_with_dot = []
        index_with_dot = []

        #gathers all the processes with dots and their index
        list.each_with_index do |process,index|
            if process.include?(".")
                keys_with_dot << process
                index_with_dot << index
            end
        end
        
        #This is necessary to deal with any process that has a 3.1 or 3.2.
        if !keys_with_dot.empty?
            formatted_keys = keys_with_dot.collect{|key| key.split(".")[1]} #gathers all the new keys
            formatted_keys.each_with_index{|new_key, index| list[index_with_dot[index]] = new_key} #replaces old keys with formatted keys
        end
    end

    #WORKING ON FIXING SPACING BUG WITH PROCESSES
    def find_process_name(process)
        keys = @process.keys
        format_list(keys)
        #formats the rest of the keys by getting rid of the numbers
        formatted_processes = keys.join.downcase.split(/\d+ /).reject{|obj| obj == ""}
        
        formatted_processes.each_with_index do |obj,index|
            return keys[index] if obj == process
        end
        
        nil
    end
    
    def results(process)
        actual_process = find_process_name(process)
        @process[actual_process]
    end
end