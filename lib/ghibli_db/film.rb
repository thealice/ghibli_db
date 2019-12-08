class GhibliDb::Film

  attr_accessor :id, :title, :description, :release_date, :url, :locations, :species, :director, :people

  @@all = []

  def initialize(attributes_hash)
    attributes_hash.each do |key, value| # this will iterate and assign attributes to a new Film based the attr_accesors set above
      self.send("#{key}=", value) if self.respond_to?(key) #checks to see if that object has a method that it can call for that key (a getter/reader method). if there is no reader for that key, it will not execute the setter for that.
    end
    @people = [] #the people array of URLs from the API is often incorrect, so wipe it here so we can fix later
  end

  def save
    @@all << self unless @@all.include?(self)
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

  def self.all_sorted # alphabetizes film list
    @@all.sort_by { |film| film.sortable_title.downcase }
  end

  def self.create_from_collection(array_of_hashes)
    array_of_hashes.each do |film_hash|
      film_object = self.new(film_hash)
      film_object.save
    end
  end

## move to findable module?
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
# end findables

end
