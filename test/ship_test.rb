require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end
  def test_it_exists_and_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
  end

  def test_ship_health
    assert_equal 3, @cruiser.health
  end

  def test_ship_starts_not_sunk
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal 2, @cruiser.health
    @cruiser.hit
    assert_equal 1, @cruiser.health
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end

end
