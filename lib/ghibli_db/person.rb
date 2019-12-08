class GhibliDb::Person
  attr_accessor :id, :name, :gender, :age, :eye_color, :hair_color, :url, :films, :species

  @@all = []

  def initialize(attributes)
    attributes.each do |key, value|
        self.send("#{key}=", value) if self.respond_to?(key)
      end
  end

  def save
    @@all << self unless @@all.include?(self)
  end

  def self.all
    @@all
  end

  def self.create(hash)
    object = self.new(hash)
    object.save
  end

  def self.find(hash)
    self.all.detect {|object| object == hash}
  end

  def self.find_or_create(hash)
    find(hash) || self.create(hash)
  end

  def self.create_from_collection(array)
    array.each do |url|
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
