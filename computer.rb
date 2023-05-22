require_relative './code'

class Computer
  attr_reader :code

  def initialize
    @code = Code.new
  end

  def check(guess)
    guess.each_with_index.map do |peg, index|
      if peg == @code.pegs[index]
        Peg::RIGHT_PLACE
      elsif @code.pegs.include?(peg)
        Peg::RIGHT_COLOR
      end
    end.compact
  end

  def win?(hints)
    hints.all? { |peg| peg == Peg::RIGHT_PLACE } && hints.size == 4
  end
end
