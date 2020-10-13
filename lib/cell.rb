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
    if empty? == false
      @ship.hit
    end
    @fired_upon = true
    @hit += 1
  end

  def render(reveal_ship = false)
    if fired_upon? && empty?
      "M"
    elsif fired_upon? && empty? == false
      "H"
    elsif fired_upon? && @ship.health == 0
      "X"
    elsif reveal_ship == true && empty? == false
      "S"
    else
      "."
    end
  end
end
