class GhibliDb::CLI

  def start
    pastel
    welcome
    make_films
    make_people
    main_menu
  end

  def welcome
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.cyan('    Welcome to the Studio Ghibli Database!') + "    ー( ´ ▽ ` )ﾉ"
    puts pastel.yellow("    ----------------------------------------------------------------------")
    sleep(1)
    spirited_img
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.cyan("    (∩｀-´)⊃━☆ﾟ.*･｡ﾟ Please be patient while I fetch the films...")
  end

  def main_menu
    input = nil
    while input != "exit"
      list_main_options
      input = gets.strip.downcase
      if input == "exit"
        goodbye
      elsif input.match?(/fil|flim|movie|movies/i)
        list_films
      elsif input.match?(/peo|pepol/i)
        list_characters
      else
        puts pastel.cyan("This is not a valid option.")
        main_menu
      end
    end
  end

  def list_main_options
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.red("    Please choose an option below or type 'exit' to exit the program:")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts "    Type " + pastel.cyan('films') + " to see a list of all the Studio Ghibli films"
    puts "    Type " + pastel.cyan('people') + " to see a list of some characters from the films"
    puts pastel.yellow("    ----------------------------------------------------------------------")
  end

  def list_films
    puts pastel.cyan("     #") + " | " + pastel.cyan("Title                            ")
    puts pastel.yellow("    ---|----------------------------------")
    GhibliDb::Film.all_sorted.each.with_index(1) do |film, index|
      puts "    #{index}" + pastel.yellow("  | ") + "#{film.title}" if index < 10
      puts "    #{index}" + pastel.yellow(" | ") + "#{film.title}" if index > 9
    end
    film_details
  end

  def list_characters
    line_break
    puts pastel.cyan("     #") + pastel.yellow(" | ") + pastel.cyan("Character                            ")
    puts pastel.yellow("    ---|----------------------------------")
      GhibliDb::Person.all.each.with_index(1) do |person, index|
          puts "    #{index}" + pastel.yellow("  | ") + "#{person.name}" if index < 10
          puts "    #{index}" + pastel.yellow(" | ") + "#{person.name}" if index > 9
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
        line_break
        puts pastel.yellow("    Name: ") + "#{person.name}"
        if person.age == ""
          puts pastel.yellow("    Age: ") + "Unknown"
        else
          puts pastel.yellow("    Age: ") + "#{person.age}"
        end
        puts pastel.yellow("    Species: ") + "#{person.species}"
        puts pastel.yellow("    Gender: ") + "#{person.gender}"
        puts pastel.yellow("    Eye Color: ") + "#{person.eye_color}"
        puts pastel.yellow("    Hair Color: ") + "#{person.hair_color}"
        if person.films.size > 1
          puts pastel.yellow("    Films: ")
          person.films.each.with_index(1) {|film, index| puts pastel.yellow("            #{index}. ") + "#{film.title}"}
        else
          puts pastel.yellow("    Film: ") + "#{person.films[0].title}"
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
        line_break
        puts pastel.yellow("----------------------------------------------------------------------------------")
        puts pastel.cyan("#{film.title}") + " was released in" + pastel.cyan(" #{film.release_date}.") + " It was directed by" + pastel.cyan(" #{film.director}.")
        puts pastel.yellow("----------------------------------------------------------------------------------")
        puts "#{film.description}"
        if film.people.size == 1
          puts pastel.yellow("-------------------")
          puts pastel.cyan("Featured Character:")
          puts pastel.yellow("-------------------")
          person = film.people[0]
          gender = person['gender'].downcase
          species = person['species'].downcase
          if gender != "" && gender != "na"
            puts "#{person['name']}, a #{gender} #{species}"
          else
            puts "#{person['name']}, a #{species}"
          end

        elsif film.people.size > 1
          puts pastel.yellow("-------------------------")
          puts pastel.cyan("Featured Characters:")
          puts pastel.yellow("-------------------------")
          film.people.each.with_index(1) do |person, index|
            gender = person['gender'].downcase
            species = person['species'].downcase
            if gender != "" && gender != "na"
              puts "#{index}. #{person['name']}, a #{gender} #{species}"
            else
              puts "#{index}. #{person['name']}, a #{species}"
            end

          end
        else
          line_break
          puts pastel.cyan("(ﾉ´ｰ`)ﾉ There are no featured characters in this film!")
        end

        line_break
        sleep(0.5)
      else
        puts pastel.cyan("This is not a valid number!")
        film_details
      end
  end

  def make_films
    GhibliDb::API.get_films
  end

  def make_people
    GhibliDb::API.get_people
  end

  def line_break
    puts ""
  end

  def goodbye
    puts "Goodbye! (￣ｰ￣)ﾉ"
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
