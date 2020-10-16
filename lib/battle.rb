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
    @user_cruiser       = Ship.new('Cruiser', 3)
    @user_submarine     = Ship.new('Submarine', 2)
    @computer_board     = Board.new
    @computer_cruiser   = Ship.new('Cruiser', 3)
    @computer_submarine = Ship.new('Submarine', 2)
    @all_coordinates    = @computer_board.cells.keys
  end

  def welcome_message
    "Welcome to BATTLESHIP\n" +
    "Enter p to play. Enter q to quit."
  end

  def go_to_battle
    puts welcome_message
    user_response = gets.chomp.downcase
    if user_response == 'p'
      #do something
    elsif user_response == 'q'
      exit
    else
    puts "That is not a valid choice, please input 'p' or 'q'"
    self.go_to_battle
    end
  end

  def generate_random_coordinates(ship)
    # require "pry"; binding.pry
    if ship.name == @computer_cruiser.name || ship.name == @user_cruiser.name
      @all_coordinates.sample(3)
    else
      @all_coordinates.sample(2)

    end
  end

  def computer_ship_placement
    # loop coordinates- sample method for random coordinates that comply with valid placement
    # place method to place ships
    until @computer_board.valid_placement?(@computer_cruiser, generate_random_coordinates(@computer_cruiser))
      sample = generate_random_coordinates(@computer_cruiser)
    end
    @computer_board.place(@computer_cruiser, sample)
  end
end
