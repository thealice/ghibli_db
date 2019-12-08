class GhibliDb::API

  BASE_URL = "https://ghibliapi.herokuapp.com"

  def self.get_films
    results = HTTParty.get("#{BASE_URL}/films")
    results = results.parsed_response
    GhibliDb::Film.create_from_collection(results)
  end

  def self.get_people #this also creates people and adds people to films...should separate this out
    results = HTTParty.get("#{BASE_URL}/people")
    people = results.parsed_response
    people.map.with_index do |person| #person is a hash
      species_hash = self.get_object_by_url(person["species"])
      person["species"] = species_hash["name"] # this does not create a species object, just assigns the species name as an attribute of the person
      person["films"] = person["films"].map do |film|
        film = GhibliDb::Film.find_or_create_by_url(film) # replace urls with film objects
      end
      new_person = GhibliDb::Person.find_or_create(person) #create people objects
    end
    people.each.with_index do |person, index|
      person["films"].each do |film| # add people to films
        film.people << person unless film.people.include?(person)
      end
    end
  end

  def self.get_object_by_url(url)
    results = HTTParty.get(url)
    results = results.parsed_response
  end

  def self.get_film_by_url(url)
    results = HTTParty.get(url)
    results = results.parsed_response
  end

end
