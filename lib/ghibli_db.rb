require "httparty"
require "pry"
require "ghibli_db/version"
require_relative 'ghibli_db/film'
require_relative 'ghibli_db/cli'
require_relative 'ghibli_db/api'


module GhibliDb
  class Error < StandardError; end
  # Your code goes here...
end
