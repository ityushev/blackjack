class Deck

  SUITS = %w[♠ ♥ ♦ ♣].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :cards

  def initialize
    @cards = build
  end

  def build
    tmp_cards = [];

    VALUES.each do |value|
      SUITS.each do |suit| 
        tmp_cards << Card.new(value, suit)
      end
    end

    return tmp_cards.shuffle
  end

  def remove_card
    @cards.shift
  end
end
