class Card
  COSTS = {'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11}

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    value + suit
  end

  def cost
    value.to_i.zero? ? COSTS[value] : value.to_i
  end

  def ace_cost
    value == 'A' ? 1 : cost
  end
end
