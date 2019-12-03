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
    puts "please enter the number corresponding to a movie you would like more information on:"
    input = gets.strip.to_i #this won't work if user types words and not a number
    input = GhibliDb::Film.all_sorted[input-1]
    puts "------------------------------------------------------"
    puts "'#{input.title}' was released in #{input.release_date}"
    puts "------------------------------------------------------"
    # need to figure out how to limit the line length of the descrpitions
    puts "#{input.description}"
    if input.people
      puts "Highlighted character(s) in this film:"
      puts input.people
    end
    # iterate through the species links associated with this movie, make that species using the API class
  end

  # def main_pick
  #   GhibliDb::API.get_films
  #   input = gets.strip
  #   if input == "1"
  #     list_films
  #   end
  # end

  def list_films #consider sorting this list
    GhibliDb::Film.make_films
    # GhibliDb::Film.all do |film|
    #   puts "#{film.num}. #{film.title}"
    # end
    tp GhibliDb::Film.all_sorted, "num", "title"
    # GhibliDb::Film.all.each.with_index(1) do |film, index|
    #   puts "#{index}. #{film.title}"
    # end
  end

end
