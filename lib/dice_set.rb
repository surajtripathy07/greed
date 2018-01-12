# Abstracts logic for rolling of the dice-set
class DiceSet
  @triplet_score = [0, 1000, 200, 300, 400, 500, 600]
  @single_score = [0, 100, 0, 0, 0, 50, 0]

  #   Rolls passed number of dice and returns the list
  def self.roll(size = 5)
    size.times.map { rand(1..6) }
  end

  #   takes care of the scoring from the passed dice
  #   returns the score from the passed dice and number of non-scoring dice
  def self.score(dice)
    return 0 if dice.empty?

    score_hash = Hash.new(0)
    s = 0
    non_scoring_dice = 0

    dice.each do |u|
      score_hash[u] += 1
      # calculating score and non-scoring-dice
      if (score_hash[u] % 3).zero?
        s += @triplet_score[u] - 2 * @single_score[u]

        non_scoring_dice -= 2 if @single_score[u].zero?

      elsif (@single_score[u]).zero?
        non_scoring_dice += 1
      else
        s += @single_score[u]
      end
    end

    [s, non_scoring_dice]
  end
end
