require './dice_set'
# Corresponds to one player of the game
class Player
  attr_accessor :name, :score, :number_of_dice, :dice_set

  def initialize(name, dice)
    @name = name
    @score = 0
    @number_of_dice = dice
  end

  #   Corresponds to a player turn.
  #   Is responsible to handle player dice rolls and consecutive turns
  def turn
    no_of_dice = number_of_dice
    play = true
    scr = 0
    # while player wishes to play
    while play
      dice_set = DiceSet.roll(no_of_dice)
      puts "Player #{name} rolls the dice #{dice_set}"

      # Collect score of the dice roll and number of non-scoring dice
      roll_scr, non_scoring_dice = DiceSet.score(dice_set)

      # If all the dice were scoring then user can re-use all the dice
      if non_scoring_dice.zero?
        puts "All the dices were scoring! Number of Dice to throw now #{number_of_dice}!"
        no_of_dice = number_of_dice
      else
        no_of_dice = non_scoring_dice
      end

      # Check if the round score was 0, if yes Exit
      if roll_scr.zero?
        scr = 0
        puts 'Score in this round: 0'
        puts 'Score in this turn: 0'
        break
      end

      scr += roll_scr
      puts "Score in this round: #{roll_scr}"
      puts "Score in this turn: #{scr}"
      puts "Total Score for player #{name}: #{@score}"

      puts "Do you want to roll the #{no_of_dice} dices?(y/n):"
      play = gets.chomp.casecmp('y').zero?
    end

    # Check basic eligibility for accumulating scores
    if @score.zero? && scr >= 300
      @score = scr
    elsif @score > 0
      @score += scr
    end

    puts "Total Score for player #{name}: #{@score}"
  end
end
