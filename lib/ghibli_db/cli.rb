class GhibliDb::CLI

  def start
    pastel
    welcome
    GhibliDb::Film.make_films ## this takes a long time to load, figure out how to shorten or move
    main_menu
  end

  def welcome
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.cyan("    Welcome to the Studio Ghibli Database!")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    sleep(1.5)
    spirited_img
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.red("    Please take a deep breath and count to ten while I fetch the films...")
  end

  def goodbye
    "Goodbye, thanks for stopping in!"
  end

  def main_menu
    puts line_break
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.red("    Choose an option below or type 'exit' to exit the program:")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts "    Type 'films' to see a list of all the Studio Ghibli films"
    puts "    Type 'characters' to see a list of some characters from the films"
    # puts "    Type 'search' to search films by title"
    puts pastel.yellow("    ----------------------------------------------------------------------")

    input = ""
    while input != "exit"
      input = gets.strip.downcase
      if input == "films" # add logic here to allow similar words
        list_films
      elsif input == "characters"
        list_characters
      elsif input == "exit"
        goodbye
      else
        puts "\nThis is not a valid option. Please choose one of the available options."
      end
    end
  end

  def list_films
    puts pastel.cyan("     #") + " | " + pastel.cyan("Title                            ")
    puts "    ---|----------------------------------"
    GhibliDb::Film.all_sorted.each.with_index(1) do |film, index|
      puts "    #{index}  | #{film.title}" if index < 10
      puts "    #{index} | #{film.title}" if index > 9
      sleep(0.25)
    end
    film_details
  end

  def list_characters
    line_break
    ## make_people?
    puts pastel.cyan("     #") + " | " + pastel.cyan("Character                            ")
    puts "    ---|----------------------------------"
      GhibliDb::Person.all.each.with_index(1) do |person, index|
        puts "    #{index}  | #{person.name}, a #{person.species}" if index < 10
        puts "    #{index} | #{person.name}, a #{person.species}" if index > 9
        sleep(0.25)
      end
      character_details
  end

  def character_details
    line_break
    puts pastel.red("Enter the number of the character you would like more information on:")
    input = gets.strip.to_i - 1
    if (0 .. GhibliDb::Person.all.size).cover?(input)
      person = GhibliDb::Person.all[input]
      puts "    Name: #{person.name}"
      # Get Species belonging to Person
      # puts "    Species: #{input.species}" if input.species
      puts "    Age: #{person.age}" if person.age
      puts "    Eye Color: #{person.eye_color}"
      puts "    Hair Color: #{person.hair_color}"
      puts "    Gender: #{person.gender}"
      puts "    Film(s): #{person.films}"
      sleep(1)
    else
      puts "Please enter a valid number"
      character_details
    end
    main_menu
  end

  def film_details
    line_break
    puts pastel.red("Enter the number of the movie you would like more information on:")
    input = ""
    while input != "exit"
      input = gets.strip.to_i - 1 #if input.to_i > 0 && input.to_i < GhibliDb::Film.all.size#this won't work if user types words and not a number
      if (0 .. GhibliDb::Film.all.size).cover?(input)
        film = GhibliDb::Film.all_sorted[input]
        # tp input, "title", "species", "release_date"
        puts pastel.yellow("--------------------------------------------------------------------------")
        puts pastel.cyan("#{film.title}") + " was released in" + pastel.cyan(" #{film.release_date}.") + " It was directed by" + pastel.cyan(" #{film.director}.")
        # puts pastel.white("It was directed by") + pastel.cyan(" #{input.director}")
        puts pastel.yellow("--------------------------------------------------------------------------")
        puts "#{film.description}"
        # # need to figure out how to limit the line length of the descrpitions
        if film.people
          line_break
          puts pastel.yellow("--------------------------------------")
          puts "Highlighted character(s) in this film:"
          puts pastel.yellow("--------------------------------------")
          film.people.each.with_index(1) {|person, index| puts "#{index}. #{person.name}"}
        end
        if film.species
          line_break
          puts pastel.yellow("------------------------------")
          puts "Species featured in this film:"
          puts pastel.yellow("------------------------------")
          film.species.each.with_index(1) { |species, index| puts "#{index}. #{species.name}"}
        end
      elsif input == "exit"
        exit
      else
        puts "Please enter a valid number"
        film_details
      end
      sleep(1)
      main_menu
    end
  end

  def line_break
    puts ""
  end

  def pastel
    pastel = Pastel.new
  end

  def spirited_img
    puts <<-DOC
    mNMMNNNmNMMNmdhyhhhhdmddyyysssyyyyyyyyyh///o+/-.``::+sysyyyyyyyyyyyyyy
    NMMMMMMMMMMMMMMMMMMMMMMMNmdhhyyyyyyyyyyh/:.``-/ooo+:.`-oyyyyyyyyyyyyyy
    NMMMMMMMMMMMMMMMMMMMMMMMMMMMMNNmmdhhhhhh:`.smNNNNNNNms-`-shhhhhhhhhhhh
    NMMMMMMMMMMMMMMMMMMMMMNNMMMMMMMMMMNmddh/`:mmmNNNNNNNddh+`.yhhdddddddmm
    NMMMMMMMMMMNNNNNMMMNNNNNNNMMMMMMMMMMNd/`.dmyyNNNNNNNhyyh:`/mmNmNMMMMMM
    mNNNMNNNMMMNNmmmmNmmmmmmmmNNNNNNNNNNNy.`+NdyyNNNNNNNdyyho`-dMMMMMMMMMM
    ddmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmNm/``sdysymNNNNNmso+os`.sMMMMMMMMMM
    ddddmmmmmmmmmmmmmmmmNNNNNNNNNNNNNNNNh:``ss::/dNNNNNmo+/os``:hNMMMNNMMM
    mNNNNNNNNNNNNNNMMMMMMMNMNNNNNNNMMNNNs-``oNhyhNNNNNNNmyoyo``-oNNNNNNNNN
    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd/-``:NdyyNNNNNNNmy/s/ `-/hmmmmmmmm
    dddddddddddhhhhhhhssssyhhhhhhhhhhhho:.```mmyyNNNNNNNmy+h- `.:ohhhhhhhh
    ddddhhhhhhhhhhhs/------:shhhhhhhhhh+:.`` oNdhNNNNNNNmyyy```.:+hhhhhhhh
    dhhhhhhhhhhhhh+----:---..ohhhhhhhhs/:.`` `dNmNNNmmmNNdh/```.:/yhhhhhhh
    hhhhhddhhhhhhy--:+:h/+/..-hhhhhhhh+/-.``  -mNNo-.../mhs` ``.:/ohhhhhhh
    hhhhyNmdyhhhhy-+sshmdy/+.-hhhhhhhy+/-.``   :dNNdhhdmho`  ``.-//yhhhhhh
    hhhydNNmyyhhhhoodhmmmmhh:/hhhhhhy+/:-.``    `:+ooo+:.    ``.-:+ohhhhhh
    ssssmNNdss/.+s+/mmmmmmmy./ssssss+::-.``                  ```.-::+ssssy
    ---+mmmdy/-..---/shddy+-`--:-:--..```                      ````..-:---
    -----:::------:/osydho++/::::::...```                       ```.....-:
    /////////////smNNNdhhhmNNNd+///....```                      ```......-
    ////////////sNmmNNNNmNNNdmNy//-...````                      ````......
    ::::::::::::dNmddmmmmmmdhNms:-...`````                      `````...``
    :::::::::::/hhdhhhhhhhhsyhho:....``````                     `````...``
    DOC
  end

end
