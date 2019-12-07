class GhibliDb::Film
  #what parts of this could come from a module if we decide to make a species class?

  attr_accessor :id, :title, :description, :release_date, :url, :locations, :species, :director, :people

  @@all = []

  #consider changing this so it doesn't automatically import certain attributes
  def initialize(attributes_hash)
    attributes_hash.each do |key, value| # this will iterate and assign attributes to a new Film based the attr_accesors set above
      self.send("#{key}=", value) if self.respond_to?(key) #checks to see if that object has a method that it can call for that key (a getter/reader method). if there is no reader for that key, it will not execute the setter for that.
    end
    @people = []
    #add people here?
  end

  def save
    @@all << self unless @@all.include?(self)
  end

  # def add_people
  #   if self.people
  #     people_array = self.people
  #     people_array =
  #     people_array.map do |person|
  #       person = GhibliDb::Person.find_or_create_by_url(person) # updates person from url to person object
  #     end
  #     # people_array.map.with_index {|person,index| person.films[index] = self}
  #     self.people = people_array
  #   end
  # end

  def add_species
    if self.species
      species_array = self.species
      species_array =
      species_array.map do |species|
        species = GhibliDb::Species.find_or_create_by_url(species) # updates species from url to person object
      end
      self.species = species_array
    end
  end

  def sortable_title
    self.title.sub(/^(the|a|an)\s+/i, "")
  end

  def self.all
    @@all
  end

  def self.clear
    @@all = []
  end

  def self.all_sorted
    @@all.sort_by { |film| film.sortable_title.downcase }
  end

  def self.create_from_collection(array_of_hashes)
    array_of_hashes.each do |film_hash|
      film_object = self.new(film_hash)
      #add people here?
      film_object.save unless self.all.include?(film_object)
    end
  end

  def self.make_films
    films = GhibliDb::API.get_films
    #add people to films
  end

  def self.add_people(array_of_people)
    self.all.each do |film_object|
      #
      # film_object.people << ????
    end

  end

## move to findable module?
  def self.find_by_id(id)
    self.all.detect {|object| object.id == id}
  end

  def self.find_by_url(url)
    self.all.detect {|object| object.url == url}
  end

  def self.create_by_url(url)
    object_hash = GhibliDb::API.get_object_by_url(url)
    self.new(object_hash).tap do |object|
        object.save unless self.all.include?(object)
      end
  end

  def self.find_or_create_by_url(url)
    find_by_url(url) || self.create_by_url(url)
  end
# end findables




end
