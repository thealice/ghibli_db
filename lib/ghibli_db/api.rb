class GhibliDb::API

  BASE_URL = "https://ghibliapi.herokuapp.com"

  def self.get_films
    results = HTTParty.get("#{BASE_URL}/films")
    results = results.parsed_response
    GhibliDb::Film.create_from_collection(results)
    # results.each do |film|
    #   id = film["id"]
    #   title = film["title"]
    #   director = film["director"]
    #   release_date = film["release_date"]
    #   url = film["url"]
    #   # people =
    #   # species =
    # end
  end

  def self.get_people
    results = HTTParty.get("#{BASE_URL}/people")
    people = results.parsed_response
    people.map do |person| #person is a hash
      id = person["id"]
      name = person["name"]
      gender = person["gender"]
      age = person["age"]
      eye_color = person["eye_color"]
      hair_color = person["hair_color"]
      person["films"] = person["films"].map do |url|
        new_film = GhibliDb::Film.find_or_create_by_url(url)
        # new_film.people << person

      end


        #     self.people = people_array
      new_person = GhibliDb::Person.find_or_create_hash(person) #person is a hash
      # binding.pry
    end
    people
  end

  def self.get_object_by_url(url)
    results = HTTParty.get(url)
    results = results.parsed_response
  end

  def self.get_film_by_url(url)
    results = HTTParty.get(url)
    results = results.parsed_response
  end

  def self.find_or_make_by_url(url)
    object_hash = get_object_by_url(url)


  end

  def self.find_by_url(url)
  end

  def self.make_by_url(url)
  end


  # def get_people_by_film_id(film_id)
  #   results = HTTParty.get("#{BASE_URL}/films/#{film_id}")
  #   results = results.parsed_response
  # end

  # def self.get_species #do i want to change this so it gets species from each film and then updates the species array to species objects or an array of species for each movie?
  #   #or do i want a get_species from individual movie based on movie id?
  #   results = HTTParty.get("#{BASE_URL}/species")
  #   results = results.parsed_response
  #   # Move this to Species class
  #   # Iterate through hash provided by API and assign attributes to new film objects
  #   results.each do |species_urls|
  #     #iterate through the species urls and pull the species from them
  #     # GhibliDb::Species.create_from_collection(species_hash) #add results to Film.all?
  #   end
  # end


end
