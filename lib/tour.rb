class Tour < ActiveRecord::Base
    belongs_to :guide
    belongs_to :tourist

  def self.list_all_tours
    tour_names = self.all.map do |tour|
      tour.name
    end
    tour_name = TTY::Prompt.new.select("Here are all the tours. Pick one to see more details:", tour_names)
    tour_info = self.find_by(name: tour_name)
    # check if remaining_spots have been assigned
    if !tour_info.remaining_spots
      tour_info.remaining_spots = tour_info.max_group_size
    end
    puts "\u{1F449} #{tour_info.name.upcase} \u{1F448}"
    puts "\u{2B50} Category: #{tour_info.category}"
    puts "\u{2B50} Location: #{tour_info.location}"
    puts "\u{2B50} Guide: #{tour_info.guide.name}"
    puts "\u{2B50} Tour Description:"
    puts tour_info.description
    puts "\u{2B50} Maximum Group Size: #{tour_info.max_group_size}"
    puts "\u{2B50} Remaining Spots: #{tour_info.remaining_spots}".colorize(:light_yellow)
    puts "\u{2B50} Duration (hours): #{tour_info.duration}"
    puts "\u{2B50} Date & Time: #{tour_info.date_time}"
    puts "\u{2B50} Where to meet: #{tour_info.meetup_point}"
    puts "\u{2B50} Price per person: $#{tour_info.price}\n\n"
    tour_info
  end

  def self.list_tours_guide(guide_instance)
    # check if this tour guide has tours already
    if guide_instance.tours == []
      TTY::Prompt.new.select("Looks like you haven't created any tours yet. What would you like to do?") do |menu|
        menu.choice "CREATE A NEW TOUR", -> {Guide.create_tour(guide_instance)}
        menu.choice "VIEW ALL TOURS", -> {Guide.view_tour_menu(guide_instance)}
        menu.choice "Back To Home", -> {Interface.new.welcome}
        menu.choice "Exit", -> {Interface.bye}
      end
    else
      guides_tours = Tour.where(guide_id: guide_instance.id)
      guides_tours_names = guides_tours.all.map do |tour|
        tour.name
      end
      guides_tour_name = TTY::Prompt.new.select("Hey #{guide_instance.name}, here are your tours. Select one to see more details:", guides_tours_names)
      tour_info = guides_tours.find_by(name: guides_tour_name)
      # check if remaining_spots have been assigned
      if !tour_info.remaining_spots
        tour_info.remaining_spots = tour_info.max_group_size
      end
      puts "\u{1F449} #{tour_info.name.upcase} \u{1F448}"
      puts "\u{2B50} Category: #{tour_info.category}"
      puts "\u{2B50} Location: #{tour_info.location}"
      puts "\u{2B50} Guide: #{tour_info.guide.name}"
      puts "\u{2B50} Tour Description:"
      puts tour_info.description
      puts "\u{2B50} Maximum Group Size: #{tour_info.max_group_size}"
      puts "\u{2B50} Remaining Spots: #{tour_info.remaining_spots}"
      puts "\u{2B50} Duration (hours): #{tour_info.duration}"
      puts "\u{2B50} Date & Time: #{tour_info.date_time}"
      puts "\u{2B50} Where to meet: #{tour_info.meetup_point}"
      puts "\u{2B50} Price per person: $#{tour_info.price}\n\n"
      sleep(2)
      TTY::Prompt.new.select("What would you like to do next?") do |menu|
        menu.choice "CANCEL THIS TOUR", -> {self.cancel_tour_guide(tour_info, guide_instance)}
        menu.choice "BACK TO MY TOURS", -> {Tour.list_tours_guide(guide_instance)}
        menu.choice "SEE ALL TOURS", -> {Guide.view_tour_menu(guide_instance)}
        menu.choice "Back To Home", -> {Interface.new.welcome}
        menu.choice "Exit", -> {Interface.bye}
      end
    end
  end

  def self.cancel_tour_guide(tour_instance, guide_instance)
    tour_instance.destroy
    Interface.tour_loading("\u{1f525}")
    Interface.play_loading_delete
    sleep(1)
    TTY::Prompt.new.select("You have canceled this tour. What would you like to do next?") do |menu|
      menu.choice "BACK TO MY TOURS", -> {self.list_tours_guide(guide_instance)}
      menu.choice "SEE ALL TOURS", -> {Guide.view_tour_menu(guide_instance)}
      menu.choice "Back To Home", -> {Interface.new.welcome}
      menu.choice "Exit", -> {Interface.bye}
    end
  end

  def self.list_tours_tourist(tourist_instance)
    # check if this tourist has tours already
    if tourist_instance.tours == []
      TTY::Prompt.new.select("Looks like you haven't added any tours yet. What would you like to do?") do |menu|
        menu.choice "ADD A NEW TOUR", -> {Tourist.book_tour_menu(tourist_instance)}
        menu.choice "Back To Home", -> {Interface.new.welcome}
        menu.choice "Exit", -> {Interface.bye}
      end
    else
      tourist_tours = Tour.where(tourist_id: tourist_instance.id)
      tourist_tours_names = tourist_tours.all.map do |tour|
        tour.name
      end
      tourist_tour_name = TTY::Prompt.new.select("OK #{tourist_instance.name}, here are your tours. Select one to see more details:", tourist_tours_names)
      tour_info = tourist_tours.find_by(name: tourist_tour_name)
      # check if remaining_spots have been assigned
      if !tour_info.remaining_spots
        tour_info.remaining_spots = tour_info.max_group_size
      end
      puts "\u{1F449} #{tour_info.name.upcase} \u{1F448}"
      puts "\u{2B50} Category: #{tour_info.guide.specialty}"
      puts "\u{2B50} Location: #{tour_info.guide.location}"
      puts "\u{2B50} Guide: #{tour_info.guide.name}"
      puts "\u{2B50} Tour Description:"
      puts tour_info.description
      puts "\u{2B50} Maximum Group Size: #{tour_info.max_group_size}"
      puts "\u{2B50} Remaining Spots: #{tour_info.remaining_spots}"
      puts "\u{2B50} Duration (hours): #{tour_info.duration}"
      puts "\u{2B50} Date & Time: #{tour_info.date_time}"
      puts "\u{2B50} Where to meet: #{tour_info.meetup_point}"
      puts "\u{2B50} Price per person: $#{tour_info.price}\n\n"
      sleep(1)
      TTY::Prompt.new.select("What would you like to do next?") do |menu|
        menu.choice "CANCEL THIS TOUR", -> {Tourist.cancel_tour(tourist_instance, tour_info)}
        menu.choice "BACK TO MY TOURS", -> {self.list_tours_tourist(tourist_instance)}
        menu.choice "SEE ALL TOURS", -> {Tourist.book_tour_menu(tourist_instance)}
        menu.choice "Back To Home", -> {Interface.new.welcome}
        menu.choice "Exit", -> {Interface.bye}
      end
    end
  end  

end