class TarkovPedia::Pedia 

    attr_accessor :interest, :name, :process
    @@all = [] #used to stored the instances
    
    # Each object is initialized with an interest, a name, and processes. Saves the instance.
    # 
    # @param interest, name [String, String] Interest - 'items, quests, etc' Name - 'bitcoin, GP coin, etc'
    # @return [String] the saved object.
    def initialize(interest, name)

        @interest = interest
        @name = name
        @process = {}
        grab_processes #grabs processes and saves to @process
        save
    end

    # Saves the pedia instance into an array of pedia. 
    # 
    # @return [Array] Array of pedia objects.  
    def save
        @@all << self
        
    end
    
    # Class method that shows all the pedia instances created.
    #
    # @return [Array] Array of pedia  objects
    def self.all
        @@all
    end
    
    # class method that finds a pedia object by the interest and name
    # 
    # @param interest, name [String, String] Interest - 'items, quests, etc' Name - 'bitcoin, GP coin, etc'
    # @return [Pedia] the first pedia obj with the same name.
    def self.find_by_interest_name(interest, name)
        obj = self.all.find{|pedia| pedia.name == name}\


    end

    # class method that finds or creates a pedia object by the interest and name
    # 
    # @param interest, name [String, String] Interest - 'items, quests, etc' Name - 'bitcoin, GP coin, etc'
    # @return [Pedia] The existing Pedia object or new created Pedia obj.
    def self.find_or_create_by_interest_name(interest, name)
        obj = self.find_by_interest_name(interest, name) # Used to check if obj already exists
        if obj.nil?
            if !TarkovPedia::Scrapper.exist?(name) #returns scapes if exists. false if it doesnt.
                false
            else
                obj = self.new(interest, name)
            end
        else
            obj
        end
    end

    # Method that lists all the processes
    #
    # @return [Array] Returns an array of strings representing the processes
    def list_processes
        @process.keys
    end

    # Method that grabs processes using the scrapper class and sets the keys to the instance varible @process
    #
    # @return [Hash] hash of keys with empty values
    def grab_processes    
        TarkovPedia::Scrapper.find_processes.each{|process, value| @process[process] = value} 
    end

    # class method that finds or creates a pedia object by the interest and name
    # 
    # @param process [String] Process - 'description', 'location', 'price', 'etc.'
    # @return [String]

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

    def find_process_name(process, list = @process.keys)
        formatted_processes = list.join.downcase.split(/\d+ /).reject{|obj| obj == ""}
        formatted_processes.each_with_index do |obj,index|
            return list[index] if obj == process
        end
        
        nil
    end

end