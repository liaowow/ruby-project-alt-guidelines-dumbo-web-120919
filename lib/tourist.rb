class Tourist < ActiveRecord::Base
  has_many :tours
  has_many :guides, through: :tours

  def self.welcome
    TTY::Prompt.new.select("Cool. First time here?") do |menu|
      menu.choice "Yup, I'm a newbie", -> {self.handle_new_user}
      menu.choice "Nope, I'm already a Turing Tourist", -> {self.handle_returning_user}
      menu.choice "Exit", -> {Interface.bye}
    end
  end

  def self.handle_new_user
    puts "What is your name?"
    name = gets.chomp
    if Tourist.find_by(name: name)
      self.handle_duplicate_names(name)
    else
      sleep(0.5)
      puts "How many people are in your group? (We can host a maximum of 20 people for each tour)"
      group_size = gets.chomp.to_i
      tourist_instance = Tourist.create(name: name, num_of_people: group_size)
      system 'clear'
      self.book_tour_menu(tourist_instance)
    end
  end

  def self.handle_duplicate_names(name)
    puts "Oops, that name is already taken in our app. Try using another name, something like #{name}111 or real#{name}. Go wild!"
    self.handle_new_user
  end

  def self.handle_returning_user
    puts "Welcome back! What is your name?"
    name = gets.chomp
    # call .wrong_input method if cannot find the name, otherwise call .main_menu
      if !Tourist.find_by(name: name)
          self.wrong_input
      else
          tourist_instance = Tourist.find_by(name: name)
          self.returning_main_menu(tourist_instance)
      end
  end

  def self.wrong_input
      puts "Oops, did you type the wrong name? Let's try again:"
      name = gets.chomp
      if !Tourist.find_by(name: name)
          self.wrong_input
      else
          tourist_instance = Tourist.find_by(name: name)
          self.returning_main_menu(tourist_instance)
      end
  end

  def self.returning_main_menu(tourist_instance)
      system "clear"
      TTY::Prompt.new.select("Welcome back, #{tourist_instance.name}! What would you like to do today?") do |menu|
          menu.choice "VIEW ALL TOURS", -> {self.book_tour_menu(tourist_instance)}
          menu.choice "SEE MY TOURS", -> {Tour.list_tours_tourist(tourist_instance)}
          menu.choice "Exit", -> {Interface.bye}
      end
  end

  def self.book_tour_menu(tourist_instance)
    system "clear"
    puts "Hello, #{tourist_instance.name}! You are now representing a group of #{tourist_instance.num_of_people}."
    sleep(1)
    selected_tour = Tour.list_all_tours
    sleep(1)
    TTY::Prompt.new.select("Would you like to book this tour?") do |menu|
      menu.choice "YES. SIGN ME UP!", -> {self.add_tour(tourist_instance, selected_tour)}
      menu.choice "VIEW OTHER TOURS", -> {self.book_tour_menu(tourist_instance)}
      menu.choice "Exit", -> {Interface.bye}
    end
  end

  def self.add_tour(tourist_instance, selected_tour)
    # check group size
    sleep(1)
    if tourist_instance.num_of_people <= selected_tour.remaining_spots
        # update remaining_spots
        selected_tour.remaining_spots -= tourist_instance.num_of_people      
        # add selected tour to tourist_instance
        tourist_instance.tours << selected_tour
        # plays add_tour animation
        Interface.tour_loading("\u{1f680}")
        # plays sound effect
        Interface.play_loading_add

        # output added tour info
        puts "Congrats, you've successfully added #{selected_tour.name}!\n"
        # follow-up menu
        sleep(1.5)
        TTY::Prompt.new.select("What would you like to do next?") do |menu|
          menu.choice "CANCEL THIS TOUR", -> {self.cancel_tour(tourist_instance, selected_tour)}
          menu.choice "VIEW ALL TOURS", -> {self.book_tour_menu(tourist_instance)}
          menu.choice "SEE MY TOURS", -> {Tour.list_tours_tourist(tourist_instance)}
          menu.choice "Exit", -> {Interface.bye}
        end
    else
      self.handle_wrong_group_size(tourist_instance, selected_tour)
    end
  end

  def self.handle_wrong_group_size(tourist_instance, selected_tour)
    puts "Oh no, your group size (#{tourist_instance.num_of_people}) is too big for this tour! \nThere are currently #{selected_tour.remaining_spots} spot(s) left.\n"
    # follow-up menu
    sleep(1)
    TTY::Prompt.new.select("What would you like to do next?") do |menu|
      menu.choice "CHANGE MY GROUP SIZE", -> {self.change_group_size(tourist_instance)}
      menu.choice "SEE ALL TOURS", -> {self.book_tour_menu(tourist_instance)}
      menu.choice "Exit", -> {Interface.bye}
    end
  end

  def self.change_group_size(tourist_instance)
    sleep(0.5)
    puts "Alright. How many people are in your group now?"
    group_size = gets.chomp.to_i
    tourist_instance.update(num_of_people: group_size)
    system 'clear'
    self.book_tour_menu(tourist_instance)
  end

  def self.cancel_tour(tourist_instance, selected_tour)
    # remove selected_tour from tourist_instance BUT DOES NOT REMOVE FROM TOURS
    tourist_instance.tours = tourist_instance.tours - [selected_tour]
    # add back remaining spots to selected_tour
    selected_tour.remaining_spots += tourist_instance.num_of_people
    # add back remaining spots to Tour
    Tour.all.where(id: selected_tour.id).update_all(remaining_spots: selected_tour.remaining_spots)
    
    ## failed attempt 1 (did not mutate the array):
    # same_tour = Tour.find_by(id: selected_tour.id)
    # same_tour.remaining_spots += tourist_instance.num_of_people

    ## failed attempt 2 (did not mutate the array):
    # Tour.all.map {|tour| tour.remaining_spots += tourist_instance.num_of_people if tour.id == selected_tour.id}

    Interface.tour_loading("\u{1f525}")
    Interface.play_loading_delete
    puts "You just canceled #{selected_tour.name}."
    sleep(1.5)
    # follow-up menu
    TTY::Prompt.new.select("What would you like to do next?") do |menu|
      menu.choice "VIEW ALL TOURS", -> {self.book_tour_menu(tourist_instance)}
      menu.choice "SEE MY TOURS", -> {Tour.list_tours_tourist(tourist_instance)}
      menu.choice "Exit", -> {Interface.bye}
    end
  end

end