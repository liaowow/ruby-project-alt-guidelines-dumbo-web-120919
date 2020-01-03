class Guide < ActiveRecord::Base
    has_many :tours
    has_many :tourists, through: :tours
  
    def self.welcome
        TTY::Prompt.new.select("Cool. First time here?") do |menu|
            menu.choice "Yup, I'm a newbie", -> {self.handle_new_user}
            menu.choice "Nope, I'm already a Turing Tour Guide", -> {self.handle_returning_user}
            menu.choice "Exit", -> {Interface.bye}
        end
    end
  
    def self.handle_new_user
      puts "Welcome, Turing newbie! What is your name?"
      name = gets.chomp
      if Guide.find_by(name: name)
        Tourist.handle_duplicate_names(name)
      else
        guide_instance = Guide.create(name: name)
        system "clear"
        TTY::Prompt.new.select("Hello, #{name}! What would you like to do today?") do |menu|
            menu.choice "VIEW ALL TOURS", -> {self.view_tour_menu(guide_instance)}
            menu.choice "CREATE A NEW TOUR", -> {self.create_tour(guide_instance)}
            menu.choice "Exit", -> {Interface.bye}
        end
      end
    end
  
    def self.handle_returning_user
      puts "Welcome back! What is your name?"
      name = gets.chomp
      # call .wrong_input method if cannot find the name, otherwise call .main_menu
        if !Guide.find_by(name: name)
            self.wrong_input
        else
            guide_instance = Guide.find_by(name: name)
            self.returning_main_menu(guide_instance)
        end
    end

    def self.wrong_input
        puts "Oops, did you type the wrong name? Let's try again:"
        name = gets.chomp
        if !Guide.find_by(name: name)
            self.wrong_input
        else
            guide_instance = Guide.find_by(name: name)
            self.returning_main_menu(guide_instance)
        end
    end

    def self.returning_main_menu(guide_instance)
        system "clear"
        TTY::Prompt.new.select("Hello again, #{guide_instance.name}! What would you like to do today?") do |menu|
            menu.choice "VIEW ALL TOURS", -> {self.view_tour_menu(guide_instance)}
            menu.choice "CREATE A NEW TOUR", -> {self.create_tour(guide_instance)}
            menu.choice "SEE MY TOURS", -> {Tour.list_tours_guide(guide_instance)}
            menu.choice "Exit", -> {Interface.bye}
        end
    end

    def self.view_tour_menu(guide_instance)
        Tour.list_all_tours
        sleep(1)
        TTY::Prompt.new.select("What would you like to do next?") do |menu|
          menu.choice "VIEW ALL TOURS", -> {self.view_tour_menu(guide_instance)}
          menu.choice "SEE MY TOURS", -> {Tour.list_tours_guide(guide_instance)}
          menu.choice "CREATE A NEW TOUR", -> {self.create_tour(guide_instance)}
          menu.choice "Back To Home", -> {Interface.new.welcome}
          menu.choice "Exit", -> {Interface.bye}
        end
      end

    def self.create_tour(guide_instance)
        # retrieve inputs
        puts "\nTask 1 of 9: Please give your tour an awesome name:"
        tour_name = gets.chomp
        puts "\nTask 2 of 9: What category is this tour? (Examples: Food, Art, History)"
        tour_category = gets.chomp
        puts "\nTask 3 of 9: What city is the tour located? (Example: New York City)"
        tour_location = gets.chomp
        puts "\nTask 4 of 9: Please write a short description for this tour:"
        tour_description = gets.chomp
        puts "\nTask 5 of 9: What's the maximum group size for this tour? (Example: 20)"
        tour_max_size = gets.chomp
        puts "\nTask 6 of 9: How long is this tour? Please write the number of hours (Example: 3)"
        tour_duration = gets.chomp
        puts "\nTask 7 of 9: When will this tour take place? (Example: January 03, 2020 3:00pm)"
        tour_datetime = gets.chomp
        puts "\nTask 8 of 9: Where is the tour meetup point? (Example: Corner of 23rd Street and 6th Ave, in front of Starbucks)"
        tour_meetup = gets.chomp
        puts "\nFinally: How much is the tour in US dollars? Please write the amount (Example: 50)"
        tour_price = gets.chomp

        # create a new tour instance based on inputs
        new_tour = Tour.create(guide_id: guide_instance.id, name: tour_name, category: tour_category, location: tour_location, description: tour_description, max_group_size: tour_max_size, duration: tour_duration, date_time: tour_datetime, meetup_point: tour_meetup, price: tour_price)

        # add this tour to this guide's tours
        guide_instance.tours << new_tour
        # play tour_loading animation
        Interface.tour_loading("\u{1f680}")
        # plays sound effect
        Interface.play_loading_add
        # output new tour info
        puts "Congrats, you've successfully created a new tour! Here it is:"
        puts "\u{1F449} #{new_tour.name.upcase} \u{1F448}"
        puts "\u{2B50} Category: #{new_tour.category}"
        puts "\u{2B50} Location: #{new_tour.location}"
        puts "\u{2B50} Guide: #{new_tour.guide.name}"
        puts "\u{2B50} Tour Description:"
        puts new_tour.description
        puts "\u{2B50} Maximum Group Size: #{new_tour.max_group_size}"
        puts "\u{2B50} Duration (hours): #{new_tour.duration}"
        puts "\u{2B50} Date & Time: #{new_tour.date_time}"
        puts "\u{2B50} Where to meet: #{new_tour.meetup_point}"
        puts "\u{2B50} Price per person: $#{new_tour.price}\n\n"
        sleep(1)
        # assign tour category and location to guide instances
        guide_instance.specialty = tour_category
        guide_instance.location = tour_location
        # follow-up menu
        TTY::Prompt.new.select("What would you like to do next?") do |menu|
            menu.choice "CANCEL THIS TOUR", -> {Tour.cancel_tour_guide(new_tour, guide_instance)}
            menu.choice "CREATE ANOTHER NEW TOUR", -> {self.create_tour(guide_instance)}
            menu.choice "SEE MY TOURS", -> {Tour.list_tours_guide(guide_instance)}
            menu.choice "VIEW ALL TOURS", -> {self.view_tour_menu}
            menu.choice "Exit", -> {Interface.bye}
        end
    end

end