class GhibliDb::Film
  #what parts of this could come from a module if we decide to make a species class?

  attr_accessor :id, :title, :description, :release_date, :url, :locations, :people, :species

  @@all = []

  def initialize(attributes)
    attributes.each do |key, value| # this will iterate and assign attributes to a new Film based the attr_accesors set above
      self.send("#{key}=", value) if self.respond_to?(key) #checks to see if that object has a method that it can call for that key (a getter/reader method). if there is no reader for that key, it will not execute the setter for that.
    end
    @people = nil if self.people == ["https://ghibliapi.herokuapp.com/people/"]
    @locations = nil if self.locations == ["https://ghibliapi.herokuapp.com/locations/"]
    @species = nil if self.species == ["https://ghibliapi.herokuapp.com/species/"]
    self.add_people
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(array_of_hashes)
    array_of_hashes.each do |film_hash|
      film_object = self.new(film_hash)
      film_object.save
    end
  end

  def self.make_films
    results = GhibliDb::API.get_films
    self.create_from_collection(results)
  end

  def add_people
    if self.people
      people_array = self.people
      people_array.each do |url|
        person_object = GhibliDb::Person.find_or_create_by_url(url)
        binding.pry
        person_object.films
      end
    end
    #def add_song(song)
    #   song.artist = self unless song.artist
    #   self.songs << song unless @songs.include?(song)
    #end
    # self.people = self.people.map do |person_url|
    #   person_object.films=() GhibliDb::Person.films=
    # end
  end
## move to findable module?
  def self.find_by_url(url)
    self.all.detect {|object| object.url == url}
  end

  def self.create_by_url(url)
    self.new(url).tap do |object|
        object.save
      end
  end

  def self.find_or_create_by_url(url)
    find_by_url(url) || self.create_by_url(url)
  end

end
