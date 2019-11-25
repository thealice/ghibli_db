class GhibliDb::Person
  attr_accessor :id, :name, :gender, :age, :eye_color, :hair_color, :url, :films, :species

  @@all = []

  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value) if self.respond_to?(key)
    end
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(array_of_hashes)
    array_of_hashes.each do |person_hash|
      person_object = self.new(person_hash)
      person_object.save
    end
  end

  def self.make_people
    results = GhibliDb::API.get_people
    self.create_from_collection(results)
  end


  # def self.films=(film_urls_array)
  #   film_objects_array = films_urls_array.each do |url|
  #     binding.pry
  #   end
  # end
end
