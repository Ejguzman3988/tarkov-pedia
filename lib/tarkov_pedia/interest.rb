class TarkovPedia::Interest
    
    @@history = []
    attr_accessor :type, :name, :process

    def initialize(type)
        @type = type
        get_name(type)
        get_process

        @@history << self
    end

    def get_name(user_select)
        puts "What is the exact name of the #{user_select.delete_suffix('s')} you wish to search for?"
        
        @name = gets.chomp.downcase
    end

    def get_process
        puts <<-DOC
        "Which process would you like to do?"
        1. description

        2. price
        
        DOC

        @process = gets.chomp.downcase



    end
end