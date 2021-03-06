class Board
  attr_reader :cells

  def initialize
    @cells = generate_cells
  end

  def generate_cells
    cells_hash = {}
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4","C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    coordinates.each do |coordinate|
      cells_hash[coordinate] = Cell.new(coordinate)
    end
    cells_hash
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    (has_same_letters_and_consecutive_numbers?(coordinates) &&
    valid_length_and_coordinate?(ship, coordinates)) ||
    (has_same_numbers_and_consecutive_letters?(coordinates) &&
    valid_length_and_coordinate?(ship, coordinates))
  end

  def letters(coordinates)
    coordinates.map do |letter|
      letter[0]
    end
  end

  def numbers(coordinates)
    coordinates.map do |number|
      number[-1]
    end
  end

  def letters_range(coordinates)
    (letters(coordinates)[0]..letters(coordinates)[-1]).to_a
  end

  def numbers_range(coordinates)
    (numbers(coordinates)[0]..numbers(coordinates)[-1]).to_a
  end

  def valid_length?(ship, coordinates)
    coordinates.count == ship.length
  end

  def one_letter?(coordinates)
    letters(coordinates).uniq.length == 1
  end

  def one_number?(coordinates)
    numbers(coordinates).uniq.length == 1
  end

  def has_same_letters_and_consecutive_numbers?(coordinates)
    one_letter?(coordinates) && numbers(coordinates) == numbers_range(coordinates)
  end

  def has_same_numbers_and_consecutive_letters?(coordinates)
    one_number?(coordinates) && letters(coordinates) == letters_range(coordinates)
  end

  def is_overlapping?(coordinate)
    coordinate.all? {|coordinate| @cells[coordinate].empty?}
  end

  def valid_length_and_coordinate?(ship, coordinates)
    valid_length?(ship, coordinates) && is_overlapping?(coordinates) &&
    coordinates.all? {|coordinate| valid_coordinate?(coordinate)}
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render_user_board
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
    "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
    "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
    "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"
  end

  def render_computer_board
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
    "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
    "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
    "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
  end
  
  def render(reveal_ship = nil)
    if reveal_ship == true
      render_user_board
    else
      render_computer_board
    end
  end
end
