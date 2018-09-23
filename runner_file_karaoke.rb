require_relative("rooms")
require_relative("guests")
require_relative("songs")
require_relative("bar")
require('pry')

room_1 = Room.new("80's", 5)
room_2 = Room.new("90's", 6)
room_3 = Room.new("00's", 7)

song1 = Song.new("Take On Me")
song2 = Song.new("Sweet Dreams")
song3 = Song.new("Every Breath You Take")
song4 = Song.new("Barbie Girl")
song4 = Song.new("Smells Like Teen Spirit")
song5 = Song.new("Truly Madly Deeply")
song6 = Song.new("Crazy in Love")
song7 = Song.new("Hey Ya!")
song8 = Song.new("Poker Face")
song9 = Song.new("Gold Digger")

songs_80 = [song1, song2, song3]
songs_90 = [song4, song5, song6]
songs_00 = [song7, song8, song9]

room_1.add_songs(songs_80)
room_2.add_songs(songs_90)
room_3.add_songs(songs_00)

bar = Bar.new([
  {name: "wine", price: 4},
  {name: "beer", price: 3},
  {name: "cider", price: 3},
  {name: "fruit juice", price: 2}])

p "What is your name?"
customer_name = gets.chomp
p "How much money do you have to spend?"
money = gets.chomp.to_i
p "What is your favourite song?"
favourite_song = gets.chomp

guest1 = Guest.new(customer_name, money, favourite_song)

p "Which room would you like to go to? Room one plays 80s music, room two plays 90s music, and room 3 plays 00s music room."
room_choice = gets.chomp.to_i
case room_choice
when 1
  room_choice = room_1
  room_1.check_in_guest(guest1)
when 2
  room_choice = room_2
  room_2.check_in_guest(guest1)
when 3
  room_choice = room_2
  room_3.check_in_guest(guest1)
else
  p "Sorry, try again"
  room_choice = gets.chomp
end

p "Would you like to set up a tab?"
tab = gets.chomp

if tab == "yes"
  room_choice.set_tab_for_customer(guest1, bar)
else
  p "Ok, please pay for your drinks as you order them"


binding.pry
nil
