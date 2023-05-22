require_relative './peg'

class Code
  attr_reader :pegs

  def initialize
    @pegs = [Peg::RED, Peg::GREEN, Peg::YELLOW, Peg::BLUE, Peg::PINK, Peg::WHITE].shuffle.take(4)
  end

  def ==(other)
    @pegs == other.pegs
  end

  def to_s
    @pegs.join(' ')
  end
end
