class TarkovPedia::Pedia

    attr_accessor :interest, :name, :process

    def initialize(interest, name, process)

        @interest = interest
        @name = name
        @process = process

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
end