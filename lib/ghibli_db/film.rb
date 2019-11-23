class GhibliDb::Film

  attr_accessor :id, :title, :description, :release_date, :species, :locations

@@all = []

def initialize(attributes) #mass assignment
  attributes.each do |key, value|
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

end
