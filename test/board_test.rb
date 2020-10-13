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

  def test_cells_are_being_created
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal expected, @board.cells.keys
    assert_equal 16, @board.cells.count
  end
end
