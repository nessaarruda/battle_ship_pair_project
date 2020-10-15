require "./lib/board"
require "./lib/ship"
require "./lib/cell"

class Battle
  attr_reader :user_board,
              :user_cruiser,
              :user_submarine,
              :computer_board,
              :computer_cruiser,
              :computer_submarine
  def initialize
    @user_board         = Board.new
    @user_cruiser       = Ship.new("Cruiser", 3)
    @user_submarine     = Ship.new("Submarine", 2)
    @computer_board     = Board.new
    @computer_cruiser   = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def welcome_message
    "Welcome to BATTLESHIP\n" +
    "Enter p to play. Enter q to quit."
  end
end
