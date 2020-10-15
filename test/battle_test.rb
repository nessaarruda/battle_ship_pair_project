require "minitest/autorun"
require "minitest/pride"
require "./lib/battle"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"

class BattleTest < Minitest::Test
  def setup
    @battle = Battle.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Battle, @battle
  end
end
