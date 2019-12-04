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
    sleep(1)
    spirited_img
    line_break
    puts pastel.red("Please wait a few moments while I fetch the films...")
  end

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
      input.species.each.with_index(1) { |species, index| puts "#{index}. #{species.name} - #{species.classification}"}
      line_break
    end
    # iterate through the species links associated with this movie, make that species using the API class
  end

  def list_films
    puts "---|----------------------------------"
    GhibliDb::Film.all_sorted.each.with_index(1) do |film, index|
      puts "#{index}  | #{film.title}" if index < 10
      puts "#{index} | #{film.title}" if index > 9
      sleep(0.25)
    end
  end

  def line_break
    puts ""
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
