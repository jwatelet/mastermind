require_relative './code'

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
    guess.pegs.uniq.each_with_index.map do |peg, index|
      if peg == @code.pegs[index]
        Peg::RIGHT_PLACE
      elsif @code.pegs.include?(peg)
        Peg::RIGHT_COLOR
      end
    end.compact.sort
  end

  def win?(hints)
    hints.all? { |peg| peg == Peg::RIGHT_PLACE } && hints.size == 4
  end
end
