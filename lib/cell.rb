class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
    @hit = 0
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
    @ship.hit if empty? == false
    @fired_upon = true
    @hit += 1
  end

  def render(reveal_ship = nil)
    if fired_upon? && empty?
      "M"
    elsif fired_upon? && empty? == false && ship.sunk?
      "X"
    elsif fired_upon? && @ship.sunk? == false && empty? == false
      "H"
    elsif reveal_ship == true && empty? == false
      "S"
    else
      "."
    end
  end
end
