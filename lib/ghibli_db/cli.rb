class GhibliDb::CLI

  def start
    welcome
    list_films
    options
  end

  def welcome
    puts "Welcome to the Studio Ghibli Database!"
    puts "--------------------------------------"
#     puts <<-DOC
# ```````````y````````````````````..````````````````````````````````````````````````..````````````````
# ```````````y````````````````````::````````````````````-.````..``````````````:.````::````````````````
# ```````````+``````````````..````--``..``````..````````//````//.````````````-/.````..````````````````
# ````--``````````````````````````::``::``````--````````//````//:.````-.````.//.````::````::```````y``
# ````//````````````````````+`````..``..``````//````````::````-::.////y+///-./:.````..````..```````y``
# ````//````````````````````:`````::``````````//````````::`````:/+++hhhhyoss//.```````````--```````y``
# ````//`````````...````````o`````//``````````//````````//``.:///////+++///////:.`````````::```````o``
# ````//```````-ossss/``````y`````//`````.````//````````..``:/+hsy///:---://ysh+/:````````..```````+``
# ````//`````.hhddhhdhh/````y````````````y````//``````````.-://oso////:::///oso/:--.``````--```````+``
# ````//`````smdhmyodhhm````y````````````y````..``````````.:::////////////////////:-```````````````/``
# ````--``--``shhhhhhhy-````y````````````y````````````.``.::++////////////////////:-.``````````````/``
# ````````//```.+osoo-``````/````````````/````````````.`.+hhhhhhyooooooooooo++//////:.``.``````o``````
# ````````::``````h.``````````````````````````````````.:ohhhdmNNNNyoooooo++ooooo+////:`````````y``````
# ````````//``````h.``````````````````````````````````/hhhhdmhhmmhmmhyoo+++/+o+/+//////-```````y``````
# ````````::``````h.```````````````````.````````::```:hhhhNNdNNNNNNNNNdoooooooooo+o+////```````y``````
# ````````..````./s--.````````````-:/++o++:-.```::``-yhhhmNmNNmhhhNNmdho+ooo+/+ooooo+///-``````.``````
# ``````````````:so+/.`````````:/+oooooooooo++:-..``:hhhmhddmNdNNNNNdNNNooo+oo+oo++/++///.````````````
# ``````````````:soo+.```````.oosss:ssss-`--:////-``ohhmNNNNNNNNNNNNNNNNmsoooooooooooo+///````````````
# ``````````````:os+/.``````./--yhddmmmy/--------:``hhdNNNNNNNNNNNNNNNNNNNooooooooooooo///````````````
# ````````````````h--.````````.-:+dddhd+hh+-----.```hhdNNNNNNNNNNNNNNNNNNNdoooooooooooo+//````````````
# ````````````````s-.`````/``````+hdhhd+hd-...``````hhdNNNNNNNNNNNNNNNNNNNNhooooooooooo+//````````````
# ````````````````h-.`````y``````.omhssymd``````````yhdNNNNNNNNNNNNNNNNNNNNNooooooooooo+//```````+````
# ````````````````h-``````y```````-hdyysyh``````````:hdNNNNNNNNNNNNNNNNNNNNNooooooooooo+/-```````-````
# ``````--````````h-``````+```````-hhhhyys```````````ohNNNNNNNNNNNNNNNNNNNNNooooooooooo/:````````+````
# ``````--````````h-``````:````````.m/.ss````````````+hhNNNNNNNNNNNNNNNNNNNdoooooooooo+/-````````:````
# ````````````````h.````````````````m/`yy`````````````hhdNNNNNNNNNNNNNNNNNmsooooooooo///``````````````
# ````````````````h.```````````````-No.hy.````````````+hhdmNNNNNNNNNNNNNNmooooooooo+///.``````````````
# ````````````so//o/::::```````````yNd/Nm:`````````````+hhhhdmNNNNNNNNNhyooooooo++////.```````````````
# ````````````hoo+::::+:```````````yNdsNm:``````````````.+hhhhs/ssyyyoooooo++++/////-.````````````````
# syysyo+o++++s+////oo+////++//////oysyys+///////++++///+soos+///:/::::::::::::::::::/----:::::///////
# sshdhysssshhyyyyssso+osso/+++++++++++++++++++++++/////////////////::::::/:/:-------:--:::------:::::
# syyhssdhhhsssyyoo+++++++++++++++++//////////////////:::::::::::::--:--:/:--:--.-..::--:----....:....
#     DOC
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
    input = GhibliDb::Film.all[input-1]
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
    GhibliDb::Film.all.each.with_index(1) do |film, index|
      puts "#{index}. #{film.title}"
    end
  end

end
