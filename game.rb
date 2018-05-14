class Game
  START_CARDS = 2
  BET_SIZE = 10
  ACTIONS = %w[take_card skip_turn show_cards]
  GAME_RESULTS = {win: 'You win', lose: 'You lose', draw: 'Draw', in_process: 'Game is in process'}

  attr_reader :bank, :player, :dealer, :deck, :finished, :player_turn, :hide_cards, :result

  def initialize(player)
    @player = player
    @dealer = Player.new
  end

  def start
    @deck = Deck.new
    @finished = false
    @hide_cards = true
    @bank = 0
    @result = GAME_RESULTS[:in_process]
    deal_cards
    place_bets
    @player_turn = true
  end

  def restart
    player.reset_cards
    dealer.reset_cards
    start
  end

  def hide_cards?
    hide_cards
  end

  def enough_money?
    player.stack >= BET_SIZE && dealer.stack >= BET_SIZE
  end

  def player_action(action_index)
    send ACTIONS[action_index]
  end

  def dealer_action
    if dealer.score < 17 && dealer.cards.size < 3
      dealer.add_card(deck.remove_card) 
    end
    end_turn
  end

  def running?
    !finished
  end

  protected

  def deal_cards
    START_CARDS.times do
      player.add_card(deck.remove_card)
      dealer.add_card(deck.remove_card)
    end
  end

  def place_bets
    player.place_bet(BET_SIZE)
    dealer.place_bet(BET_SIZE)
    @bank += BET_SIZE * 2
  end

  def take_card
    player.add_card(deck.remove_card) if player.cards.size < 3 
    end_turn
  end

  def skip_turn
    end_turn
  end

  def show_cards
    @hide_cards = false
    @finished = true
    count_score
  end

  def end_turn
    @player_turn = !player_turn
    show_cards if (max_cards_dealt? || score_limit_exceeded?)
  end

  def max_cards_dealt?
    player.cards.size > 2 && (dealer.cards.size > 2 || player_turn)
  end

  def score_limit_exceeded?
    player.score > 21 || dealer.score > 21
  end

  def count_score
    if dealer_won?
      dealer.increase_stack(bank)
      @result = GAME_RESULTS[:lose]
    elsif player_won?
      player.increase_stack(bank)
      @result = GAME_RESULTS[:win]
    else
      dealer.increase_stack(bank/2)
      player.increase_stack(bank/2)
      @result = GAME_RESULTS[:draw]
    end
  end

  def dealer_won?
    (player.score > 21) || (dealer.score > player.score && dealer.score < 22)
  end

  def player_won?
    (dealer.score > 21) || (player.score > dealer.score && player.score < 22)
  end
end
