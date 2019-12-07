class GhibliDb::CLI

  def start
    pastel
    welcome
    GhibliDb::API.get_films
    GhibliDb::API.get_people
    main_menu
  end

  def welcome
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.cyan("    Welcome to the Studio Ghibli Database!")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    sleep(1.5)
    spirited_img
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.cyan("    Please wait a moment while I fetch the films...")
    line_break
  end

  def main_menu
    input = nil
    while input != "exit"
      list_main_options
      input = gets.strip.downcase
      if input == "exit"
        goodbye
      elsif input == "films" # add logic here to allow similar words
        list_films
      elsif input == "people"
        list_characters
      else
        puts pastel.cyan("This is not a valid option.")
        main_menu
      end
    end
  end

  def list_main_options
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.red("    Choose an option below or type 'exit' to exit the program:")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts "    Type 'films' to see a list of all the Studio Ghibli films"
    puts "    Type 'people' to see a list of some characters from the films"
    puts pastel.yellow("    ----------------------------------------------------------------------")
  end

  def list_films
    puts pastel.cyan("     #") + " | " + pastel.cyan("Title                            ")
    puts "    ---|----------------------------------"
    GhibliDb::Film.all_sorted.each.with_index(1) do |film, index|
      puts "    #{index}  | #{film.title}" if index < 10
      puts "    #{index} | #{film.title}" if index > 9
    end
    film_details
  end

  def list_characters
    line_break
    puts pastel.cyan("     #") + " | " + pastel.cyan("Character                            ")
    puts "    ---|----------------------------------"
      GhibliDb::Person.all.each.with_index(1) do |person, index|
          puts "    #{index}  | #{person.name}" if index < 10
          puts "    #{index} | #{person.name}" if index > 9
      end
      character_details
  end

  def character_details
    line_break
    puts pastel.red("Please enter the number of the character you would like more information on:")
    input = nil
      input = gets.strip.downcase
      if input === "exit"
        goodbye
      end
      input = input.to_i - 1
      if (0 .. GhibliDb::Person.all.size).cover?(input)
        person = GhibliDb::Person.all[input]
        puts "    Name: #{person.name}"
        if person.age == ""
          puts "    Age: Unknown"
        else
          puts "    Age: #{person.age}"
        end
        puts "    Eye Color: #{person.eye_color}"
        puts "    Hair Color: #{person.hair_color}"
        puts "    Gender: #{person.gender}"
        if person.films.size > 1
          puts "    Films: "
          person.films.each.with_index(1) {|film, index| puts "            #{index}. #{film.title}"}
        else
          puts "    Film: #{person.films[0].title}"
        end
        line_break
        sleep(0.5)
      else
        puts pastel.cyan("This is not a valid number!")
        character_details
      end
  end

  def film_details
    line_break
    puts pastel.red("Please enter the number of the film you would like more information on:")
    input = nil
      input = gets.strip.downcase
      input = input.to_i - 1
      if (0 .. GhibliDb::Film.all.size).cover?(input)
        film = GhibliDb::Film.all_sorted[input]
        puts pastel.yellow("----------------------------------------------------------------------------------")
        puts pastel.cyan("#{film.title}") + " was released in" + pastel.cyan(" #{film.release_date}.") + " It was directed by" + pastel.cyan(" #{film.director}.")
        puts pastel.yellow("----------------------------------------------------------------------------------")
        puts "#{film.description}"
        sleep(0.5)
      else
        puts pastel.cyan("This is not a valid number!")
        film_details
      end
  end

  def line_break
    puts ""
  end

  def goodbye
    puts "Goodbye!"
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
