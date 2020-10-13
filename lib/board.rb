class Board

  def initialize

  end

  def cells
    cells_hash = {}
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    coordinates.each do |coordinate|
      cells_hash[coordinate] = Cell.new(coordinate)
    end
    cells_hash
  end

  end
