class Peg
  RED = "\033[31m●\033[0m".freeze
  GREEN = "\033[32m●\033[0m".freeze
  YELLOW = "\033[33m●\033[0m".freeze
  BLUE = "\033[34m●\033[0m".freeze
  PINK = "\033[35m●\033[0m".freeze
  WHITE = "\033[37m●\033[0m".freeze
  ALL_PEGS = [Peg::RED, Peg::GREEN, Peg::YELLOW, Peg::BLUE, Peg::PINK, Peg::WHITE].freeze

  RIGHT_PLACE = "\033[37m■\033[0m".freeze
  RIGHT_COLOR = "\033[37m□\033[0m".freeze

  def self.create(char)
    case char
    when 'r'
      RED
    when 'g'
      GREEN
    when 'y'
      YELLOW
    when 'b'
      BLUE
    when 'p'
      PINK
    when 'w'
      WHITE
    end
  end
end
