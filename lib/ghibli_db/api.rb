class GhibliDb::API

  BASE_URL = "https://ghibliapi.herokuapp.com"

  def self.get_films
    results = HTTParty.get("#{BASE_URL}/films")
    results = results.parsed_response
    GhibliDb::Film.create_from_collection(results)
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
      end
      new_person = GhibliDb::Person.find_or_create_hash(person) #person is a hash
    end
    ## Is this doing anything????
    people.map.with_index do |person_hash, index|
      person_hash["films"].each do |film|
        film.people << person_hash unless film.people.include?(person_hash)
      end
    end
    # people[index]["films"][index].people
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

end
