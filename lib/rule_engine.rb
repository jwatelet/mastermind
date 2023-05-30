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
    guess_without_right_place = []
    code_without_right_place = @code.pegs.map(&:clone)
    guess.pegs.each_with_index do |peg, index|
      if peg == @code.pegs[index]
        hints << Peg::RIGHT_PLACE
        code_without_right_place.delete_at(index)
      else
        guess_without_right_place << peg
      end
    end

    guess_without_right_place.map do |peg|
      hints << Peg::RIGHT_COLOR if code_without_right_place.include?(peg)
    end

    Hint.new(hints)
  end
end
