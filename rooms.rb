require('pry')

class Room

  attr_reader :name, :fee
  attr_accessor :till, :capacity, :songs, :guests, :tabs

  def initialize(name, fee)
    @name = name
    @capacity = 20
    @till = 0
    @songs = []
    @fee = fee
    @guests = []
    @tabs = []
  end

  def check_in_guest(guest)
    if @capacity == 0
      return "Sorry, this room is full!"
    else
      guest.pay_fee(@fee)
      @capacity -= 1
      @till += @fee
      @guests << guest
    end
  end

  def check_out_guest(guest, bar)
    for tab in @tabs
      if tab[:name] == guest.name
        guest.wallet -= tab[:spent]
        bar.total_income += tab[:spent]
        @tabs.delete(tab)
      end
    end
    @capacity += 1
    @guests.delete(guest)
  end

  def add_songs(songs)
    for song in songs
      @songs << song
    end
  end

  def remove_song(song)
    @songs.delete(song)
  end

  def play_song_in_room(requested_song)
    for guest in @guests
      if guest.fav_song == requested_song.title
        return guest.cheer
      end
    end
    return requested_song.play_song
  end

  def set_tab_for_customer(customer, bar)
    for guest in @guests
      if guest.name == customer.name
       @tabs << {name: customer.name, spent: 0}
     end
   end
   return "This customer has not checked in"
  end

  def add_drink_to_tab(customer, drink, bar)
    to_charge = price_of_drink(drink, bar)
    for guest in @tabs
      if guest[:name] == customer.name
        return guest[:spent] += to_charge
      end
    end
    customer.buys_drink(bar.drinks, drink)
    bar.sell_drink(drink)
  end

  def price_of_drink(drink, bar)
    for item in bar.drinks
      if item[:name] == drink
        return item[:price]
      end
    end
    return "That drink does not exist"
  end

end
