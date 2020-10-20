class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit if !empty?
    @fired_upon = true
  end

  def render(reveal_ship = nil)
    if fired_upon? && empty?
      "M"
    elsif fired_upon? && !empty? && ship.sunk?
      "X"
    elsif fired_upon? && !@ship.sunk? && !empty?
      "H"
    elsif reveal_ship == true && !empty?
      "S"
    else
      "."
    end
  end
end
