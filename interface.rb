class Interface
  PLAYER_ACTIONS = ['Pick a card', 'Skip turn', 'Show cards'].freeze

  attr_reader :game

  def initialize(game)
    @game = game
  end

  def show_game_info
    system 'clear'
    show_bank
    show_player_info(game.dealer)
    show_player_info(game.player)
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
    puts "Bank = #{game.bank}"
  end

  def show_stack(player)
    print " | Stack: #{player.stack}"
  end

  def show_score(player)
    print " | Score: #{player.score}\n"
  end

  def request_action
    puts "Select option"
    PLAYER_ACTIONS.each.with_index(1) { |action, i| puts "#{i}: #{action}" }
    gets.to_i - 1
  end

  def continue_request
    puts 'Press enter to continue or type "exit" to stop the game'
    exit if gets.chomp == 'exit' 
  end

  def replay_request
    puts 'Replay? (y/n)'
    game.restart if gets.chomp == 'y'
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
      #continue_request

      replay_request if game.finished

    end

  end
end
