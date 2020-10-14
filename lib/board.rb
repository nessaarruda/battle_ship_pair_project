class Board
  attr_reader :cells

  def initialize
    @cells = generate_cells
  end

  def generate_cells
    cells_hash = {}
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    coordinates.each do |coordinate|
      cells_hash[coordinate] = Cell.new(coordinate)
    end
    cells_hash
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinate)
    letters = []
    numbers = []
    coordinate.each do |letter|
      letters << letter[0]
      numbers << letter[-1]
    end
    numbers_range = numbers[0]..numbers[-1]
    letters_range = letters[0]..letters[-1]
    if letters_range.to_a.uniq.length == 1 && numbers == numbers_range.to_a && coordinate.count == ship.length
      true
    elsif letters_range.to_a.uniq.length != 1 && letters == letters_range.to_a && numbers.all? == true && coordinate.count == ship.length
      true
    else
      false
    end
  end
end
