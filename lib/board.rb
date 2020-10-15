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
    elsif letters_range.to_a.uniq.length != 1 && letters == letters_range.to_a && numbers.one? && coordinate.count == ship.length
      true
    else
      false
    end
  end

  def place(ship, coordinate)
    if valid_placement?(ship, coordinate)
      coordinate.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render(reveal_ship = true)
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
    "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
    "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
    "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n"
  end
end
