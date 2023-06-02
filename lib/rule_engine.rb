require_relative './code'
require_relative './hint'

class RuleEngine
  attr_reader :code

  def initialize(**hash)
    @code = initialize_code(hash)
  end

  def initialize_code(hash)
    if hash[:code].nil?
      Code.new
    else
      hash[:code]
    end
  end

  def check(guess)
    hints = []
    wrong_guess_pegs = []
    wrong_answer_pegs = []
    peg_pairs = guess.pegs.zip(@code.pegs)

    peg_pairs.each do |guess_peg, answer_peg|
      if guess_peg == answer_peg
        hints << Peg::RIGHT_PLACE
      else
        wrong_guess_pegs << guess_peg
        wrong_answer_pegs << answer_peg
      end
    end

    wrong_guess_pegs.each do |peg|
      if wrong_answer_pegs.include?(peg)
        hints << Peg::RIGHT_COLOR
      end
    end

    Hint.new(hints)
  end
end
