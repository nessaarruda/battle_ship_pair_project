class Ship

  attr_reader :name, :health, :sunk, :length

  def initialize(name, length)
    @name = name
    @length = length
    @health = @length
  end

  # def health
  #   @length
  # end

  def sunk?
    # if @health == 0
    #   true
    # else
    #   @sunk
    # end
    @health <= 0

  end

  def hit

    @health -= 1
  end
end
