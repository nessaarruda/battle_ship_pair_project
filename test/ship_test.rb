require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists_and_has_attributes
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
  end

end
