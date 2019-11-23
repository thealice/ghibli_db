class GhibliDb::CLI

  def start
    welcome
    list_films
    options
  end

  def welcome
    puts "Welcome to the Studio Ghibli Database!"
    puts "--------------------------------------"
  end

  # def menu
  #   # add .gsub /^\s*/, '' below to keep the indentation from the Here DOC from displaying in the CLI
  #   # puts <<-DOC
  #   #   ------------------------------------------------------------------
  #   #   Please choose an option number or type "exit" to exit the program:
  #   #   ------------------------------------------------------------------
  #   #   1. I would like to see a list of all the Studio Ghibli films
  #   #   2. I would like to search for a Studio Ghibli film
  #   #   ------------------------------------------------------------------
  #   # DOC
  #   #   # 3. I would like a to see a list of species included in the films
  #   #   # 4. I would like to search the films by title
  #   #   # 5. I would like to search the films by species
  #   #   # 6. I would like some trivia / facts / a quiz
  #     main_pick
  # end

  def options
    puts ""
    puts "please enter the number corresponding to a movie you would like more information on"
    input = gets.strip
  end

  # def main_pick
  #   GhibliDb::API.get_films
  #   input = gets.strip
  #   if input == "1"
  #     list_films
  #   end
  # end

  def list_films
    GhibliDb::Film.make_films
    GhibliDb::Film.all.each.with_index(1) do |film, index|
      puts "#{index}. #{film.title}"
    end
  end

end
