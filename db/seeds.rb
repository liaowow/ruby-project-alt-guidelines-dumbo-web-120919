require 'database_cleaner'
DatabaseCleaner.clean_with(:truncation)

Guide.destroy_all
Tourist.destroy_all
Tour.destroy_all

# Guides
allan = Guide.create(name: "Allan", password: "alman25", location: "New York City", specialty: "Food", years_of_experience: 5)
guide1 = Guide.create(name: Faker::TvShows::GameOfThrones.character, password: Faker::Internet.password, location: Faker::Address.city, specialty: "Art", years_of_experience: Faker::Number.between(from: 1, to: 25))
guide2 = Guide.create(name: Faker::TvShows::HowIMetYourMother.character, password: Faker::Internet.password, location: Faker::Address.city, specialty: "Art", years_of_experience: Faker::Number.between(from: 1, to: 25))
guide3 = Guide.create(name: Faker::TvShows::BreakingBad.character, password: Faker::Internet.password, location: Faker::Address.city, specialty: "History", years_of_experience: Faker::Number.between(from: 1, to: 25))
guide4 = Guide.create(name: Faker::TvShows::GameOfThrones.character, password: Faker::Internet.password, location: Faker::Address.city, specialty: "Food", years_of_experience: Faker::Number.between(from: 1, to: 25))
guide5 = Guide.create(name: Faker::TvShows::Friends.character, password: Faker::Internet.password, location: Faker::Address.city, specialty: "History", years_of_experience: Faker::Number.between(from: 1, to: 25))

# Tourists
annie = Tourist.create(name: "Annie", password: "einna", num_of_people: 8)
tourist1 = Tourist.create(name: Faker::Name.name, password: Faker::Internet.password, num_of_people: Faker::Number.between(from: 2, to: 30))
tourist2 = Tourist.create(name: Faker::Name.name, password: Faker::Internet.password, num_of_people: Faker::Number.between(from: 2, to: 30))
tourist3 = Tourist.create(name: Faker::Name.name, password: Faker::Internet.password, num_of_people: Faker::Number.between(from: 2, to: 30))
tourist4 = Tourist.create(name: Faker::Name.name, password: Faker::Internet.password, num_of_people: Faker::Number.between(from: 2, to: 30))
tourist5 = Tourist.create(name: Faker::Name.name, password: Faker::Internet.password, num_of_people: Faker::Number.between(from: 2, to: 30))

# Tours
nyc_foodie = Tour.create(guide_id: allan.id, tourist_id: annie.id, name: Faker::Movie.quote, category: allan.specialty, location: allan.location, description: Faker::Restaurant.description, max_group_size: 12, duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99), remaining_spots: 12 - annie.num_of_people)

tour1 = Tour.create(guide_id: allan.id, tourist_id: annie.id, name: Faker::Music.album, category: allan.specialty, location: allan.location, description: Faker::Restaurant.description, max_group_size: 19, duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 7,  period: :morning, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99), remaining_spots: 19 - annie.num_of_people)

tour2 = Tour.create(guide_id: guide1.id, tourist_id: annie.id, name: Faker::Book.title, category: guide1.specialty, location: guide1.location, description: Faker::Restaurant.description, max_group_size: 18, duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99), remaining_spots: 18 - annie.num_of_people)

tour3 = Tour.create(guide_id: guide1.id, tourist_id: tourist1.id, name: Faker::TvShows::HowIMetYourMother.quote, category: guide1.specialty,location: guide1.location, description: Faker::Restaurant.description, max_group_size: 20, duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour4 = Tour.create(guide_id: guide2.id, tourist_id: tourist5.id, name: Faker::Music.album, category: guide2.specialty, location: guide2.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour5 = Tour.create(guide_id: guide2.id, tourist_id: tourist4.id, name: Faker::Restaurant.name, category: guide2.specialty, location: guide2.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour6 = Tour.create(guide_id: guide3.id, tourist_id: tourist3.id, name: Faker::Music.album, category: guide3.specialty, location: guide3.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour7 = Tour.create(guide_id: guide4.id, tourist_id: tourist2.id, name: Faker::Quote.yoda, category: guide4.specialty, location: guide4.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour8 = Tour.create(guide_id: guide5.id, tourist_id: tourist2.id, name: Faker::Quote.singular_siegler, category: guide5.specialty, location: guide5.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour9 = Tour.create(guide_id: guide4.id, tourist_id: tourist3.id, name: Faker::Music.album, category: guide4.specialty, location: guide4.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour10 = Tour.create(guide_id: guide4.id, tourist_id: tourist2.id, name: Faker::Music.album, category: guide4.specialty, location: guide4.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 30), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour11 = Tour.create(guide_id: guide5.id, tourist_id: tourist2.id, name: Faker::Quote.singular_siegler, category: guide5.specialty, location: guide5.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour12 = Tour.create(guide_id: guide4.id, tourist_id: tourist3.id, name: Faker::Music.album, category: guide4.specialty, location: guide4.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))

tour13 = Tour.create(guide_id: allan.id, tourist_id: annie.id, name: Faker::Quote.singular_siegler, category: allan.specialty, location: allan.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 7,  period: :morning, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99), remaining_spots: annie.num_of_people)

tour14 = Tour.create(guide_id: guide1.id, tourist_id: annie.id, name: Faker::Book.title, category: guide1.specialty, location: guide1.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99), remaining_spots: annie.num_of_people)

tour15 = Tour.create(guide_id: guide1.id, tourist_id: tourist1.id, name: Faker::Movie.quote, category: guide1.specialty, location: guide1.location, description: Faker::Restaurant.description, max_group_size: Faker::Number.between(from: 12, to: 20), duration: Faker::Number.between(from: 1, to: 4), date_time: Faker::Time.forward(days: 20,  period: :evening, format: :long), meetup_point: Faker::Space.planet, price: Faker::Number.between(from: 20, to: 99))