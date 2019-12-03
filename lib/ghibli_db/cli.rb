class GhibliDb::CLI

  def start
    welcome
    GhibliDb::Film.make_films ## this takes a long time to load, figure out how to shorten
    list_films
    options
  end

  def welcome
    pastel = Pastel.new
    puts pastel.cyan("Welcome to the Studio Ghibli Database!")
    puts pastel.red("Please wait a few moments while I fetch the films...")
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
    line_break
    pastel = Pastel.new
    puts pastel.red("Enter the number of the movie you would like more information on:")
    input = gets.strip.to_i #this won't work if user types words and not a number
    input = GhibliDb::Film.all_sorted[input-1]
    # tp input, "title", "species", "release_date"
    puts pastel.yellow("------------------------------------------------------")
    puts pastel.cyan("#{input.title}") + " was released in" + pastel.cyan(" #{input.release_date}")
    puts pastel.yellow("------------------------------------------------------")
    puts "#{input.description}"
    # # need to figure out how to limit the line length of the descrpitions
    if input.people
      line_break
      puts pastel.yellow("--------------------------------------")
      puts "Highlighted character(s) in this film:"
      puts pastel.yellow("--------------------------------------")
      input.people.each.with_index(1) {|person, index| puts "#{index}. #{person.name}"}
    end
    if input.species
      line_break
      puts pastel.yellow("------------------------------")
      puts "Species featured in this film:"
      puts pastel.yellow("------------------------------")
      puts input.species
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

  def list_films
    puts "---|----------------------------------"
    GhibliDb::Film.all_sorted.each.with_index(1) do |film, index|
      puts "#{index}  | #{film.title}" if index < 10
      puts "#{index} | #{film.title}" if index > 9
      sleep(0.25)
    end
    # GhibliDb::Film.all do |film|
    #   puts "#{film.num}. #{film.title}"
    # end
    # tp GhibliDb::Film.all_sorted, "num", "title"
    # GhibliDb::Film.all.each.with_index(1) do |film, index|
    #   puts "#{index}. #{film.title}"
    # end
  end

  def line_break
    puts ""
  end

end
