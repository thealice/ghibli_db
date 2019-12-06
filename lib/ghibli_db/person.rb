class GhibliDb::Person
  attr_accessor :id, :name, :gender, :age, :eye_color, :hair_color, :url, :films, :species

  @@all = []

  def initialize(attributes)
    # @id = id
    # @name = name
    # @films = films
    attributes.each do |key, value|
        self.send("#{key}=", value) if self.respond_to?(key)
      end
  end
  # def initialize(attributes)
  #   attributes.each do |key, value|
  #     self.send("#{key}=", value) if self.respond_to?(key)
  #   end
  #   @films = nil if self.films == ["https://ghibliapi.herokuapp.com/films/"]
  #   self.add_films
  # end

  def save
    @@all << self
  end

  def add_films
      if self.films
        films_array = self.films
        films_array = films_array.map do |film|
          film = GhibliDb::Film.find_by_url(film) # updates person from url to person object
        end

        # people_array.map.with_index {|person,index| person.films[index] = self}
        self.films = films_array
      end
  end

  def self.all
    @@all
  end

  def self.create(person_hash)
    object = self.new(person_hash)
    object.save
  end

  def self.create_from_collection(array_of_urls)
    array_of_urls.each do |url|
      object = self.create_by_url(url)
      object.save
    end
  end

  def self.find_by_id(id)
    self.all.detect {|object| object.id == id}
  end

  def self.find_by_url(url)
    self.all.detect {|object| object.url == url}
  end

  def self.create_by_url(url)
    object_hash = GhibliDb::API.get_object_by_url(url)
    self.new(object_hash).tap do |object|
        object.save
      end
  end

  def self.find_or_create_by_url(url)
    find_by_url(url) || self.create_by_url(url)
  end

  # def self.make_people
  #   results = GhibliDb::API.get_people
  #   self.create_from_collection(results)
  # end
######?
  # def films=(url_collection)
  #   url_collection.each do |url|
  #     GhibliDb::Film.find_or_create_by_url(url)
  #   end
  # end


  # def self.films=(film_urls_array)
  #   film_objects_array = films_urls_array.each do |url|
  #     binding.pry
  #   end
  # end
end
