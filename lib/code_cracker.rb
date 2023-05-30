require_relative './rule_engine'
require_relative './peg'

class CodeCracker
  def initialize(rule_engine)
    @rule_engine = rule_engine
    @combinations = generate_all_combinations
  end

  def crack
    @rule_engine.check(initial_guess)
  end

  def initial_guess
    Code.new(code: [Peg::RED, Peg::RED, Peg::BLUE, Peg::BLUE])
  end

  def generate_all_combinations
    Peg::ALL_PEGS.repeated_combination(4).to_a
  end
end
