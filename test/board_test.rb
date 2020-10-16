require "minitest/autorun"
require "minitest/pride"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Board, @board
  end

  def test_cells_are_being_created
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal expected, @board.cells.keys
    assert_equal 16, @board.cells.count
  end

  def test_if_coordinate_is_valid
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_it_can_find_all_letters
    coordinate = ["A1", "B1", "C1"]

    assert_equal ['A', 'B', 'C'], @board.letters(coordinate)

    coordinate = ["C4", "D4"]

    assert_equal ['C', 'D'], @board.letters(coordinate)
  end

  def test_it_can_find_all_numbers
    coordinate = ["A1", "A2", "A3"]

    assert_equal ['1', '2', '3'], @board.numbers(coordinate)

    coordinate = ["D1", "D2"]

    assert_equal ['1', '2'], @board.numbers(coordinate)
  end

  # def test_letters_array
  #   assert_equal ["A"], @board.letters_array(["A1", "A2", "A3"])
  # end
  #
  # def test_numbers_array
  #   assert_equal ["1", "2", "3"], @board.numbers_array(["A1", "A2", "A3"])
  # end
  #
  # def test_length_of_ship_is_valid
  #   assert_equal true, @board.valid_length?(@cruiser, ["A1", "A2", "A3"])
  # end
  #
  # def test_coordinate_count_same_as_ship_length
  #   assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
  #   assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  # end
  #
  # def test_coordinates_are_consecutive
  #   assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
  #   assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
  #   assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
  #   assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
  # end
  #
  # def test_it_is_not_diagonal
  #   assert_equal false, @board.valid_placement?(@cruiser,  ["A1", "B2", "C3"])
  #   assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  # end
  #
  # def test_it_is_not_overlapping
  #   @board.place(@cruiser, ["A1", "A2", "A3"])
  #   assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
  # end
  #
  # def test_it_can_place_a_ship
  #   # Because a Ship occupies more than one cell, multiple Cells will contain
  #   # the same ship
  #   @board.place(@cruiser, ["A1", "A2", "A3"])
  #   assert_equal @cruiser, @cell_1.ship
  #   assert_equal @cruiser, @cell_2.ship
  #   assert_equal @cruiser, @cell_3.ship
  # end

  # def test_it_can_render_a_board
  #   expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
  #   assert_equal expected, @board.render
  #   expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
  #   @board.place(@cruiser, ["A1", "A2", "A3"])
  #   assert_equal expected, @board.render(true)
  # end
end
