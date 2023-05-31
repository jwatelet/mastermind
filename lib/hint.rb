class Hint
  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end

  def ==(other)
    @pegs == other.pegs
  end

  def to_s
    @pegs.join(' ')
  end

  def right_place_count
    @pegs.count(Peg::RIGHT_PLACE)
  end

  def right_color_count
    @pegs.count(Peg::RIGHT_COLOR)
  end

  def win?
    @pegs.all? { |peg| peg == Peg::RIGHT_PLACE } && @pegs.size == 4
  end
end
