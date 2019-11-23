class GhibliDb::API

  BASE_URL = "https://ghibliapi.herokuapp.com"

  def self.get_films
    results = HTTParty.get("#{BASE_URL}/films")
    results = results.parsed_response
  end

  def self.get_species #do i want to change this so it gets species from each film and then updates the species array to species objects or an array of species for each movie?
    results = HTTParty.get("#{BASE_URL}/species")
    results = results.parsed_response
    # Move this to Species class
    # Iterate through hash provided by API and assign attributes to new film objects
    results.each do |species_urls|
      #iterate through the species urls and pull the species from them
      # GhibliDb::Species.create_from_collection(species_hash) #species don't really need their own class probably so could add results to Film.all?
    end
  end

  def self.get_film_by_id(id)

  end


end
