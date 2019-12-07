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

  def add_films # confirm return value
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

  def self.create(object_hash)
    object = self.new(object_hash)
    object.save
  end

  def self.find(object_hash)
    self.all.detect {|object| object == object_hash}
  end

  def self.find_or_create_hash(hash)
    find(hash) || self.create(hash)
  end

  def self.create_from_collection(array_of_urls)
    array_of_urls.each do |url|
      object = self.create_by_url(url)
      object.save
    end
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

end
