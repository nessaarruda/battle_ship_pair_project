require "minitest/autorun"
require "minitest/pride"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Board, @board
  end
end
