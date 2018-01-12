require_relative './Game'

puts 'Enter number of players'
no_of_players = begin
                  Integer(gets)
                rescue StandardError
                  false
                end
raise 'Please pass valid input for no_of_players' unless no_of_players
raise 'Minimum 2 players required to play the game' unless no_of_players > 1

g = Game.new(no_of_players, 5)
g.play_game
