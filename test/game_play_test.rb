require 'minitest/autorun'
require 'minitest/pride'
require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/battle"
require "./lib/game_play"

class GamePlayTest < Minitest::Test

  def setup
    @game = GamePlay.new
  end

  def test_it_exists_and_has_attributes

  end

end
