require './lib/board'
require './lib/ship'
require './lib/cell'

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

  def go_to_battle
    puts welcome_message
    user_response = gets.chomp.downcase
    if user_response == 'p'
      start_game
    elsif user_response == 'q'
      exit
    else
      puts "That is not a valid choice, please input 'p' or 'q'"
      go_to_battle
    end
  end

  def start_game
    computer_ship_placement
    user_ship_placement
    until end_game?
      display_board
      user_hit
      computer_hit
    end
    win_game
    go_to_battle
  end

  def welcome_message
    "Welcome to BATTLESHIP\n" +
    "Enter p to play. Enter q to quit."
  end

  def win_game
    if @computer_cruiser.sunk? && @computer_submarine.sunk?
      puts 'You won!'
    elsif @user_submarine.sunk? && @user_submarine.sunk?
      puts 'I won!'
    end
  end

  def end_game?
    @computer_cruiser.sunk? && @computer_submarine.sunk? || @user_submarine.sunk? && @user_submarine.sunk?
  end

  def computer_ship_placement
    place_computer_ships_cruiser
    place_computer_ships_submarine
  end

  def user_ship_placement
    user_instructions
    render_user_board_and_instructions_cruiser
    get_user_coordinates_cruiser
    render_user_board_and_instructions_submarine
    get_user_coordinates_submarine
  end

  def generate_random_coordinates_computer(ship)
    if ship.name == @computer_cruiser.name
      @computer_board.cells.keys.sample(3)
    else
      @computer_board.cells.keys.sample(2)
    end
  end

  def place_computer_ships_cruiser
    sample = generate_random_coordinates_computer(@computer_cruiser)
    until @computer_board.valid_placement?(@computer_cruiser, sample)
      sample = generate_random_coordinates_computer(@computer_cruiser)
    end
    @computer_board.place(@computer_cruiser, sample)
  end

  def place_computer_ships_submarine
    sample = generate_random_coordinates_computer(@computer_submarine)
    until @computer_board.valid_placement?(@computer_submarine, sample)
      sample = generate_random_coordinates_computer(@computer_submarine)
    end
    @computer_board.place(@computer_submarine, sample)
  end

  def user_instructions
    puts ('-' * 60).to_s
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts "The Cruiser is three units long and the Submarine is two units long.\n"
    puts 'Keep in mind ships cannot be placed diagonally'
    puts ('-' * 60).to_s
  end

  def render_user_board_and_instructions_cruiser
    puts @user_board.render(true)
    puts 'Enter the coordinates for the Cruiser (3 spaces):'
  end

  def render_user_board_and_instructions_submarine
    puts @user_board.render(true)
    puts 'Enter the coordinates for the Submarine (2 spaces):'
  end

  def get_user_coordinates_cruiser
    user_coordinates = gets.chomp.upcase.split(' ')
    until @user_board.valid_placement?(@user_cruiser, user_coordinates)
      puts 'These coordinates are invalid, please try again'
      user_coordinates = gets.chomp.upcase.split(' ')
    end
    @user_board.place(@user_cruiser, user_coordinates)
  end

  def get_user_coordinates_submarine
    user_coordinates = gets.chomp.upcase.split(' ')
    until @user_board.valid_placement?(@user_submarine, user_coordinates)
      puts 'These coordinates are invalid, please try again'
      user_coordinates = gets.chomp.upcase.split(' ')
    end
    @user_board.place(@user_submarine, user_coordinates)
  end

  def display_board
    puts '=============COMPUTER BOARD============='
    puts @computer_board.render(true)
    puts '===============USER BOARD==============='
    puts @user_board.render(true)
    puts ('-' * 40).to_s
  end

  def user_hit
    puts 'Choose the coordinate for your shot'
    user_hit = gets.chomp.upcase
    if @computer_board.valid_coordinate?(user_hit) && !@computer_board.cells[user_hit].fired_upon?
      # require "pry"; binding.pry
      @computer_board.cells[user_hit].fire_upon
      hit_or_miss_user?(@computer_board.cells[user_hit])
    elsif @computer_board.valid_coordinate?(user_hit) && @computer_board.cells[user_hit].fired_upon?
      puts "You've already chosen this coordinate #{user_hit.upcase}, please try again"
      user_hit = gets.chomp.upcase
    else
      puts "The coordinate #{user_hit} is not valid, please try again"
      user_hit = gets.chomp.upcase
    end
  end

  def computer_hit
    computer_shot = @user_board.cells.keys.shuffle[0]
    until @user_board.valid_coordinate?(computer_shot)
      computer_shot = @user_board.cells.keys.shuffle[0]
    end
    @user_board.cells[computer_shot].fire_upon
    hit_or_miss_computer?(@user_board.cells[computer_shot])
  end

  def hit_or_miss_user?(cell)
    if cell.render == 'M'
      p "Your shot on #{cell.coordinate} was a miss."
    elsif cell.render == 'H'
      puts "Your shot on #{cell.coordinate} was a hit"
    elsif cell.render == 'X'
      puts 'You sunk my ship'
    end
  end

  def hit_or_miss_computer?(cell)
    if cell.render == 'M'
      puts "My shot on #{cell.coordinate} was a miss."
    elsif cell.render == 'H'
      puts "My shot on #{cell.coordinate} was a hit"
    elsif cell.render == 'X'
      puts 'I sunk your ship'
    end
  end
end
