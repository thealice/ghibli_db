class GhibliDb::Species
  attr_accessor :id, :name, :classification, :eye_colors, :hair_colors, :url, :films, :people

  @@all = []

  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value) if self.respond_to?(key)
    end
    #######if species end up being https://ghibliapi.herokuapp.com/species/ then replace with "n/a"
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(array_of_urls)
    array_of_urls.each do |url|
      object = self.create_by_url(url)
      bject.save
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
