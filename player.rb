class Player
  INITIAL_STACK = 100

  attr_reader :stack, :cards, :name

  def initialize(name = 'dealer')
    @name = name
    @stack = INITIAL_STACK
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def place_bet(bet_size)
    raise "not enough money in stack" if bet_size > @stack
    @stack -= bet_size
  end

  def score
    score = 0
    cards.each { |card| score += (score > 10 ? card.ace_cost : card.cost) }
    score
  end

  def is_dealer?
    name == 'dealer'
  end

  def reset_cards
    @cards = []
  end

  def increase_stack(amount)
    @stack += amount
  end

end
