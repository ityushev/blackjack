class Interface
  PLAYER_ACTIONS = ['Pick a card', 'Skip turn', 'Show cards'].freeze
  DELIMETER = '-------------------------------------------'

  attr_reader :game

  def initialize(game)
    @game = game
  end

  def run
    game.start
    while game.running?
      show_game_info
      if game.player_turn
        game.player_action(request_action)
      else
        game.dealer_action
      end
      show_game_info

      replay_request if game.finished
    end
  end

  protected

  def show_game_info
    system 'clear'
    show_title
    show_bank
    show_player_info(game.player)
    show_player_info(game.dealer)
  end

  def show_title
    puts "#{DELIMETER}\n             Blackjack Game\n#{DELIMETER}"
  end

  def show_player_info(player)
    print "#{player.name}: "
    show_cards(player)
    show_stack(player)
    show_score(player)
  end

  def show_cards(player)
    player.cards.each do |card| 
      if player.is_dealer? && game.hide_cards?
        card = '*'
      end
      print "#{card} " 
    end
  end

  def show_bank
    puts "Bank = $#{game.bank}"
    puts DELIMETER
  end

  def show_stack(player)
    print " | Stack: $#{player.stack}"
  end

  def show_score(player)
    score = (player.is_dealer? && game.hide_cards?) ? '*' : player.score
    print " | Score: #{score}\n"
  end

  def request_action
    puts DELIMETER
    puts "Select option"
    PLAYER_ACTIONS.each.with_index(1) { |action, i| puts "#{i}: #{action}" }
    gets.to_i - 1
  end

  def replay_request
    puts DELIMETER
    puts game.result
    if game.enough_money?  
      puts 'Replay? (y/n)'
      game.restart if gets.chomp.downcase == 'y'
    else
      puts 'Game over'
    end
  end


end
