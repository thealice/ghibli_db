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
    line_break
  end

  def main_menu
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts pastel.red("    Choose an option number or type 'exit' to exit the program:")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts "    1. I would like to see a list of all the Studio Ghibli films"
    puts "    2. I would like to see a list of some characters from the films"
    puts pastel.yellow("    ----------------------------------------------------------------------")
    # 3. I would like a to see a list of species included in the films
    # 4. I would like to search the films by title
    # 5. I would like to search the films by species
    # 6. I would like to search for a Studio Ghibli film
    input = gets.strip.to_i
    if input == 1
      list_films
      film_options
    elsif input == 2
      list_characters
      character_options
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
  end

  def film_details
    line_break
    pastel
    puts pastel.red("Enter the number of the movie you would like more information on:")
    input = gets.strip.to_i #this won't work if user types words and not a number
    input = GhibliDb::Film.all_sorted[input-1]
    # tp input, "title", "species", "release_date"
    puts pastel.yellow("--------------------------------------------------------------------------")
    puts pastel.cyan("#{input.title}") + " was released in" + pastel.cyan(" #{input.release_date}.") + " It was directed by" + pastel.cyan(" #{input.director}.")
    # puts pastel.white("It was directed by") + pastel.cyan(" #{input.director}")
    puts pastel.yellow("--------------------------------------------------------------------------")
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
      input.species.each.with_index(1) { |species, index| puts "#{index}. #{species.name}"}
      line_break
    end
  end

  def film_options
    puts pastel.red("    Choose an option number or type 'exit' to exit the program:")
    puts pastel.yellow("    ----------------------------------------------------------------------")
    puts "    1. I would like to see a list of all the Studio Ghibli films"
    puts "    2. I would like to see a list of some characters from the films"
    puts "    3. I would like to see more about a character from this film" # display this only if the movie has people
    puts "    4. I would like to see more about a species from this film" # display this only if the movie has species
    puts pastel.yellow("    ----------------------------------------------------------------------")
    input = gets.strip.to_i
    if input == 1
      list_films
      film_options
    elsif input == 2
      list_characters
      character_options
    elsif input == 3
      line_break
      puts pastel.yellow("--------------------------------------")
      puts "Highlighted character(s) in this film:"
      puts pastel.yellow("--------------------------------------")
      #this needs to call on the input from film_details
      input.people.each.with_index(1) {|person, index| puts "#{index}. #{person.name}"}
      line_break
      puts pastel.red("Enter the number of the character you would like more information on:")
## need to add logic for this
    end

  end

  def character_options

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
