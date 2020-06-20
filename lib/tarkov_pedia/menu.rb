class TarkovPedia::Menu 
    attr_reader :interest, :name, :process
    @@main_menu = <<-DOC
        1. Items
        2. Quests
    DOC

    def interest
        puts @@main_menu
        @interest = gets.chomp.downcase
        @interest
    end


end