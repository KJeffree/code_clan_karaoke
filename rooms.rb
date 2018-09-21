class Room

  attr_reader :name, :fee
  attr_accessor :till, :capacity, :songs, :guests

  def initialize(name, fee)
    @name = name
    @capacity = 20
    @till = 0
    @songs = []
    @fee = fee
    @guests = []
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

  def check_out_guest(guest)
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
    for song in @songs
      if song == requested_song
        song.play_song
      end
    end
    for guest in @guests
      if guest.fav_song == requested_song
        guest.cheer
      end
    end
  end


end
