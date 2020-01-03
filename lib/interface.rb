class Interface

    attr_accessor :prompt, :guide, :tourist

    def initialize()
        @prompt = TTY::Prompt.new
    end 

    def welcome
        system 'clear'
        puts "Welcome to...".colorize(:light_yellow)
        sleep(1)
        puts "
████████╗██╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ 
╚══██╔══╝██║   ██║██╔══██╗██║████╗  ██║██╔════╝ 
   ██║   ██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗
   ██║   ██║   ██║██╔══██╗██║██║╚██╗██║██║   ██║
   ██║   ╚██████╔╝██║  ██║██║██║ ╚████║╚██████╔╝
   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝                                                                                                 
        ".colorize(:yellow)
        sleep(1)
        puts "
        ████████╗ ██████╗ ██╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ 
        ╚══██╔══╝██╔═══██╗██║   ██║██╔══██╗██║████╗  ██║██╔════╝ 
           ██║   ██║   ██║██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗
           ██║   ██║   ██║██║   ██║██╔══██╗██║██║╚██╗██║██║   ██║
           ██║   ╚██████╔╝╚██████╔╝██║  ██║██║██║ ╚████║╚██████╔╝
           ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝                                                                                                 
        ".colorize(:yellow)
        sleep(1)
        puts "
                BEST fake-tour-booking app in 
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                |D|u|m|b|o|W|e|b|1|2|0|9|1|9|
                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+       
        \n".colorize(:light_yellow)
        sleep(1.5)
        answer = prompt.select("Are you a Tourist or a Tour Guide?") do |menu|
            menu.choice "Tourist", -> {Tourist.welcome}
            menu.choice "Guide", -> {Guide.welcome}
            menu.choice "Exit", -> {Interface.bye}
        end
    end

    def self.bye
        Chick.go
        puts "
                    THANKS FOR CHOOSING TURING TOURING".colorize(:light_yellow)
        puts "
                            SEE YOU SOON \u{1f44B}".colorize(:light_yellow)
        puts "
        ^^      ..                                       ..
                []                                       []
              .:[]:_          ^^                       ,:[]:.
            .: :[]: :-.                             ,-: :[]: :.
          .: : :[]: : :`._                       ,.': : :[]: : :.
        .: : : :[]: : : : :-._               _,-: : : : :[]: : : :.
    _..: : : : :[]: : : : : : :-._________.-: : : : : : :[]: : : : :-._
    _:_:_:_:_:_:[]:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:[]:_:_:_:_:_:_
    !!!!!!!!!!!![]!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!![]!!!!!!!!!!!!!
    ^^^^^^^^^^^^[]^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^[]^^^^^^^^^^^^^
                []                                       []
                []                                       []
                []                                       []
     ~~^-~^_~^~/  \~^-~^~_~^-~_^~-^~_^~~-^~_~^~-~_~-^~_^/  \~^-~_~^-~~-
        ".colorize(:light_red)
        puts "
            'Travel is about going from the place you’re tired of".colorize(:light_yellow)
        puts "
             to the place others are tired of.' — Anonymous\n\n\n\n".colorize(:light_yellow)
    end

    def self.tour_loading(symbol)
        system 'clear'
        circles = "#{symbol}●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●"
        40.times do
          system 'clear'
          puts circles
          new_circles = circles.insert(0, "●")
          new_circles.slice!(new_circles.length-1, new_circles.length)
          circles = new_circles
          sleep(0.06)
        end
    end

    def self.play_loading_add
      pid = fork{exec 'afplay', "lib/clap.mp3"}
    end

    def self.play_loading_delete
      pid = fork{exec 'afplay', "lib/boo.mp3"}
    end
end