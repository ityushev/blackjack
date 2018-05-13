require_relative 'player'
require_relative 'card'
require_relative 'deck'
require_relative 'game'
require_relative 'interface'

puts 'Enter your name'
name = gets.chomp
player = Player.new(name)

game = Game.new(player)

interface = Interface.new(game)

interface.run
