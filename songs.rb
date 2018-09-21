class Song

  attr_reader :title

  def initialize(title)
    @title = title
  end

  def play_song
    return "song is playing!"
  end

end
