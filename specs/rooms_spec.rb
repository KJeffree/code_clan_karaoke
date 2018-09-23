require('minitest/autorun')
require('minitest/rg')
require_relative('../rooms')
require_relative('../guests')
require_relative('../songs')
require_relative('../bar')
require('pry')

class TestRooms < MiniTest::Test

  def setup
    @song1 = Song.new("Take On Me")
    song2 = Song.new("Sweet Dreams")
    song3 = Song.new("Every Breath You Take")
    @song4 = Song.new("Barbie Girl")
    song4 = Song.new("Smells Like Teen Spirit")
    song5 = Song.new("Truly Madly Deeply")
    song6 = Song.new("Crazy in Love")
    song7 = Song.new("Hey Ya!")
    song8 = Song.new("Poker Face")
    song9 = Song.new("Gold Digger")

    @songs_80 = [@song1, song2, song3]
    @songs_90 = [@song4, song5, song6]
    @songs_00 = [song7, song8, song9]

    @guest1 = Guest.new("Charlie", 30, "Take On Me")
    @guest2 = Guest.new("Milly", 3, "Crazy in Love")
    @guest3 = Guest.new("Max", 20, "Hey Ya!")

    @room1 = Room.new("80's", 5)
    @room2 = Room.new("90's", 6)
    @room3 = Room.new("00's", 7)

    @bar = Bar.new([
      {name: "wine", price: 4},
      {name: "beer", price: 3},
      {name: "cider", price: 3},
      {name: "fruit juice", price: 2}])
  end

  def test_room_has_name
    assert_equal("80's", @room1.name)
  end

  def test_room_has_capacity
    assert_equal(20, @room1.capacity)
  end

  def test_room_has_till
    assert_equal(0, @room1.till)
  end

  def test_room_has_songs
    assert_equal([], @room1.songs)
  end

  def test_room_has_fee
    assert_equal(5, @room1.fee)
  end

  def test_room_checks_in_customer__enough_space
    @room1.check_in_guest(@guest1)
    assert_equal(19, @room1.capacity)
    assert_equal(20, @room2.capacity)
    assert_equal(25, @guest1.wallet)
    assert_equal(5, @room1.till)
    assert_equal(1, @room1.guests.count)
  end

  def test_room_checks_in_customer__not_enough_space
    20.times {@room1.check_in_guest(@guest1)}
    assert_equal(0, @room1.capacity)
    result = @room1.check_in_guest(@guest1)
    assert_equal("Sorry, this room is full!", result)
  end

  def test_room_checks_out_customer
    @room1.check_in_guest(@guest1)
    assert_equal(1, @room1.guests.count)
    @room1.check_out_guest(@guest1, @bar)
    assert_equal(0, @room1.guests.count)
    assert_equal(20, @room1.capacity)
  end

  def test_add_song_to_room
    @room1.add_songs(@songs_80)
    @room2.add_songs(@songs_90)
    @room3.add_songs(@songs_00)
    assert_equal(3, @room1.songs.length)
    assert_equal(3, @room2.songs.length)
    assert_equal(3, @room3.songs.length)
  end

  def test_remove_song_from_room
    @room1.add_songs(@songs_80)
    assert_equal(3, @room1.songs.length)
    @room1.remove_song(@song1)
    assert_equal(2, @room1.songs.length)
  end

  def test_customer_cheers_when_fav_song_played
    @room1.add_songs(@songs_80)
    @room1.check_in_guest(@guest1)
    result = @room1.play_song_in_room(@song1)
    result2 = @room2.play_song_in_room(@song4)
    assert_equal("Whoooo!", result)
    assert_equal("song is playing!", result2)
  end

  def test_customer_sets_up_tab__has_checked_in
    @room1.check_in_guest(@guest1)
    @room1.set_tab_for_customer(@guest1, @bar)
    assert_equal(1, @room1.tabs.length)
  end

  def test_customer_set_up_tab__has_not_checked_in
    assert_equal("This customer has not checked in", @room1.set_tab_for_customer(@guest1, @bar))
  end

  def test_add_drink_to_tab
    @room1.check_in_guest(@guest1)
    @room1.set_tab_for_customer(@guest1, @bar)
    @room1.add_drink_to_tab(@guest1, @bar.drinks[0], @bar)
    assert_equal(4, @room1.tabs[0][:spent])
    assert_equal(25, @guest1.wallet)
  end

  def test_sell_drink_if_no_tab
    @room1.check_in_guest(@guest1)
    result = @room1.add_drink_to_tab(@guest1, @bar.drinks[1], @bar)
    assert_equal(22, @guest1.wallet)
    assert_equal(3, @bar.total_income)
  end

  def test_if_customer_pays_tab_when_they_check_out
    @room1.check_in_guest(@guest1)
    @room1.set_tab_for_customer(@guest1, @bar)
    @room1.add_drink_to_tab(@guest1, @bar.drinks[0], @bar)
    @room1.add_drink_to_tab(@guest1, @bar.drinks[1], @bar)
    @room1.add_drink_to_tab(@guest1, @bar.drinks[2], @bar)
    @room1.check_out_guest(@guest1, @bar)
    assert_equal(15, @guest1.wallet)
    assert_equal(10, @bar.total_income)
    assert_equal(5, @room1.till)
    assert_equal(0, @room1.tabs.length)
  end
end
