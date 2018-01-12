require_relative './player'

# Resembles a Greed Game
class Game
  attr_accessor :players, :turn, :is_final_round, :winner

  def initialize(number_of_players, number_of_dice)
    @players = number_of_players.to_i.times.map do
      puts 'Enter player name: '
      name = gets.chomp
      Player.new(name, number_of_dice)
    end
    @turn = 0
    @is_final_round = false
  end

  #   Responsible to handle the game
  #   Takes in turn to let players play and
  #   also is responsible to figure out the end of game
  #   Declares a winner in the end

  def play_game
    loop do
      @turn += 1
      puts '########################################'
      puts "Turn #{@turn}:"
      puts '########################################'
      @players.each do |p|
        puts ''
        p.turn
        next unless !@is_final_round && p.score >= 3000
        @is_final_round = true
        final_round(p)
        break
      end

      break if @is_final_round
    end
  end

  #   Gets called when the final round of game is triggered
  #   Is responsible to keep track of the maximum scoring individual
  #   and declare a winner in the end

  def final_round(starting_player)
    @winner = starting_player
    puts 'Final Round started!'
    puts ''
    @players.each do |p|
      next if p == starting_player
      p.turn
      @winner = p if p.score > @winner.score
    end
    puts "Congratulations! #{@winner.name} won the game with #{@winner.score} points!"
  end
end
