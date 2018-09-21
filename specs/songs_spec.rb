require('minitest/autorun')
require('minitest/rg')
require_relative('../songs')

class TestSongs < MiniTest::Test

  def setup
    @song1 = Song.new("Can you feel the love tonight")
    @song2 = Song.new("Mr Brightside")
  end

  def test_song_has_title
    assert_equal("Mr Brightside", @song2.title)
  end

  def test_song_can_play
    assert_equal("song is playing!", @song2.play_song)
  end

end
