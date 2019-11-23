class GhibliDb::Film
  #what parts of this could come from a module if we decide to make a species class?

  attr_accessor :id, :title, :description, :release_date, :species, :locations

@@all = []

def initialize(attributes) #mass assignment
  attributes.each do |key, value| # this will iterate and assign attributes to each new Film based the attr_accesors set above
    self.send("#{key}=", value) if self.respond_to?(key) #checks to see if that object has a method that it can call for that key (a getter/reader method). if there is no reader for that key, it will not execute the setter for that.
  end
end

def save
  @@all << self
end

def self.all
  @@all
end

def self.create_from_collection(attributes)
  new_film = GhibliDb::Film.new(attributes)
  new_film.save
end

# def self.find_by_id(id)
#   self.all.detect {|film| film.id == id}
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
