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
  end

  def welcome_message
    "Welcome to BATTLESHIP\n" +
    "Enter p to play. Enter q to quit."
  end

  def go_to_battle
    puts welcome_message
    user_response = gets.chomp.downcase
    if user_response == 'p'
      start_game
    elsif user_response == 'q'
      exit
    else
    puts "That is not a valid choice, please input 'p' or 'q'"
    self.go_to_battle
    end
  end

  def start_game
    computer_ship_placement
    user_ship_placement
  end

  def computer_ship_placement
    until @computer_board.valid_placement?(@computer_cruiser, generate_random_coordinates_computer(@computer_cruiser))
      sample = generate_random_coordinates_computer(@computer_cruiser)
    end
    @computer_board.place(@computer_cruiser, sample)
    until @computer_board.valid_placement?(@computer_submarine, generate_random_coordinates_computer(@computer_submarine))
      sample = generate_random_coordinates_computer(@computer_submarine)
    end
    @computer_board.place(@computer_submarine, sample)
  end

  def user_ship_placement
    user_instructions
    render_user_board_and_instructions_cruiser
    generate_random_coordinates_user_cruiser
    render_user_board_and_instructions_submarine
    generate_random_coordinates_user_submarine
  end

  def generate_random_coordinates_computer(ship)
    if ship.name == @computer_cruiser.name || ship.name == @user_cruiser.name
      @computer_board.cells.keys.sample(3)
    else
      @computer_board.cells.keys.sample(2)
    end
  end

  def user_instructions
    puts "#{"-" * 60}"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long.\n"
    puts "Keep in mind ships cannot be placed diagonally"
    puts "#{"-" * 60}"
  end

  def render_user_board_and_instructions_cruiser
    puts @user_board.render(true)
    puts "Enter the coordinates for the Cruiser (3 spaces):"
  end

  def render_user_board_and_instructions_submarine
    puts @user_board.render(true)
    puts "Enter the coordinates for the Submarine (2 spaces):"
  end

  def generate_random_coordinates_user_cruiser
    user_coordinates = gets.chomp.upcase.split(" ")
    until @user_board.valid_placement?(@user_cruiser, user_coordinates)
      puts "These coordinates are invalid, please try again"
      user_coordinates = gets.chomp.upcase.split(" ")
    end
    @user_board.place(@user_cruiser, user_coordinates)
  end

  def generate_random_coordinates_user_submarine
    user_coordinates = gets.chomp.upcase.split(" ")
    until @user_board.valid_placement?(@user_submarine, user_coordinates)
      puts "These coordinates are invalid, please try again"
      user_coordinates = gets.chomp.upcase.split(" ")
    end
    @user_board.place(@user_submarine, user_coordinates)
  end
end
