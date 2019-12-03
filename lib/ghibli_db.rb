require "table_print"
require "pastel"
require "httparty"
require "pry"
require_relative "ghibli_db/version"
require_relative 'ghibli_db/film'
require_relative 'ghibli_db/person'
require_relative 'ghibli_db/species'
require_relative 'ghibli_db/cli'
require_relative 'ghibli_db/api'


module GhibliDb
  class Error < StandardError; end
  # Your code goes here...
end
