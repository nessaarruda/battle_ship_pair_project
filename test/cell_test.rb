require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_and_has_attributes
    assert_equal "B4", @cell.coordinate
  end

  def test_ships_can_be_placed
    assert_nil @cell.ship
    assert_equal true, @cell.empty?
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_its_been_fired_upon
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end
end
