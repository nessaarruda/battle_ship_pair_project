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
    assert_instance_of Ship, @battle.user_submarine
    assert_instance_of Ship, @battle.computer_submarine
    assert_instance_of Ship, @battle.user_cruiser
    assert_instance_of Ship, @battle.computer_cruiser
    assert_instance_of Board, @battle.user_board
    assert_instance_of Board, @battle.computer_board
  end

  def test_it_states_a_welcome_message
    expected = "Welcome to BATTLESHIP\n" +
    "Enter p to play. Enter q to quit."
    assert_equal expected, @battle.welcome_message
  end

  def test_it_is_random_and_valid_coordinates
    assert_equal 3, @battle.computer_ship_placement.count
  end

  def test_it_can_generate_sample_for_both_ships
    ship = Ship.new("cruiser", 3)
    assert_equal 3, @battle.generate_random_coordinates(ship).count
    ship = Ship.new("submarine", 2)
    assert_equal 2, @battle.generate_random_coordinates(ship).count
  end
end
