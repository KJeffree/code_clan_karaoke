class Bar

  attr_accessor :drinks, :total_income

  def initialize(drinks)
    @drinks = drinks
    @total_income = 0
  end

  def sell_drink(drink)
    for item in @drinks
      if item[:name] == drink
        @total_income += item[:price]
      end
    end
  end

end
