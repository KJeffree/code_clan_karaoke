class Guest

  attr_reader :name, :fav_song
  attr_accessor :wallet

  def initialize(name, wallet, fav_song)
    @name = name
    @wallet = wallet
    @fav_song = fav_song
  end

  def pay_fee(fee)
    if @wallet >= fee
      @wallet -= fee
    else
      return false
    end
  end

  def cheer
    return "Whoooo!"
  end
end
