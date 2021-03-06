require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../guests')
require_relative('../rooms')
require_relative('../bar')

class TestGuests < MiniTest::Test

  def setup
    @guest1 = Guest.new("Charlie", 30, "Hey Ya!")
    @guest2 = Guest.new("Milly", 3, "Sweet Dreams")
    @room1 = Room.new("80's", 5)
    @room2 = Room.new("90's", 6)
    @room3 = Room.new("00's", 7)
    @bar = Bar.new([
      {name: "wine", price: 4},
      {name: "beer", price: 3},
      {name: "cider", price: 3},
      {name: "fruit juice", price: 2}])
  end

  def test_guest_has_name
    assert_equal("Charlie", @guest1.name)
  end

  def test_guest_has_money
    assert_equal(30, @guest1.wallet)
  end

  def test_customer_can_check_in__enough_money
    @guest1.pay_fee(@room1.fee)
    assert_equal(25, @guest1.wallet)
  end

  def test_customer_can_check_in__not_enough_money
    @guest2.pay_fee(@room2.fee)
    assert_equal(3, @guest2.wallet)
  end

  def test_cusomter_has_favourite_song
    assert_equal("Hey Ya!", @guest1.fav_song)
  end

  def test_customer_can_cheer
    assert_equal("Whoooo!", @guest1.cheer)
  end

  def test_guest_buys_drink_from_bar
    @guest1.buys_drink(@bar.drinks, "wine")
    assert_equal(26, @guest1.wallet)
  end

end
