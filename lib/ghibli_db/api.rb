class GhibliDb::API

  BASE_URL = "https://ghibliapi.herokuapp.com"

  def self.get_films
    results = HTTParty.get("#{BASE_URL}/films")
    results = results.parsed_response
    results.each do |film_hash|
      GhibliDb::Film.create_from_collection(film_hash)
    end
  end

end
