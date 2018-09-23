require("minitest/autorun")
require("minitest/rg")
require_relative("../bar")

class TestBar < MiniTest::Test

  def setup
    @bar = Bar.new([
      {name: "wine", price: 4},
      {name: "beer", price: 3},
      {name: "cider", price: 3},
      {name: "fruit juice", price: 2}])
  end

  def test_bar_has_drinks
    assert_equal(4, @bar.drinks.length)
  end

  def test_drink_has_name
    assert_equal("wine", @bar.drinks[0][:name])
  end

  def test_drink_has_price
    assert_equal(2, @bar.drinks[3][:price])
  end

  def test_sell_drink
    @bar.sell_drink("cider")
    assert_equal(3, @bar.total_income)
  end

end
