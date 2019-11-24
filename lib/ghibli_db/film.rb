class GhibliDb::Film
  #what parts of this could come from a module if we decide to make a species class?

  attr_accessor :id, :title, :description, :release_date, :species, :locations

@@all = []

def initialize(attributes)
  attributes.each do |key, value| # this will iterate and assign attributes to a new Film based the attr_accesors set above
    self.send("#{key}=", value) if self.respond_to?(key) #checks to see if that object has a method that it can call for that key (a getter/reader method). if there is no reader for that key, it will not execute the setter for that.
    # Figure out how to add species and locations correctly
  end
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

# def self.find_by_id(title)
#   self.all.detect {|film| film.title == title}
# end
#
# def self.create_by_id(id)
#   self.new(id).tap do |film|
#       film.save
#     end
# end
#
# def self.find_or_create_by_id(id)
#   find_by_id(id) || self.create_by_id(id)
# end
end
