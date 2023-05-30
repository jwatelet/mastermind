require_relative './peg'

class Code
  ALL_PEGS = [Peg::RED, Peg::GREEN, Peg::YELLOW, Peg::BLUE, Peg::PINK, Peg::WHITE]

  attr_reader :pegs

  def initialize(**hash)
    @pegs = initialize_pegs(hash)
  end

  def initialize_pegs(hash)
    if hash[:color_string]
      hash[:color_string].split('').map do |char|
        Peg.create(char)
      end
    else
      @pegs = 4.times.map { random_peg }
    end
  end

  def ==(other)
    @pegs == other.pegs
  end

  def to_s
    @pegs.join(' ')
  end

  def random_peg
    ALL_PEGS.sample
  end
end
