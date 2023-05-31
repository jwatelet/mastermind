require_relative './rule_engine'
require_relative './peg'
require_relative './display'

class CodeCracker
  def initialize(hash)
    @main_rule_engine = hash[:rule_engine]
    @remaining_guesses = hash[:remaining_guesses]
    @all_codes = generate_all_codes
    @display = Dislay.new
  end

  def crack
    until @remaining_guesses.negative?
      @display.puts_steps(@remaining_guesses)
      guess = generate_guess
      puts guess
      hint = @main_rule_engine.check(guess)
      puts hint
      return guess if hint.win?

      rule_engine_with_guess = RuleEngine.new(code: guess)

      @all_codes.select! do |code|
        guess_check = rule_engine_with_guess.check(code)
        guess_check == hint
      end
      @remaining_guesses -= 1
    end
  end

  def generate_guess
    case @remaining_guesses
    when 12 then Code.new(code: [Peg::RED, Peg::RED, Peg::BLUE, Peg::BLUE])
    when 11 then Code.new(code: [Peg::YELLOW, Peg::YELLOW, Peg::GREEN, Peg::GREEN])
    when 10 then Code.new(code: [Peg::WHITE, Peg::WHITE, Peg::PINK, Peg::PINK])
    else
      @all_codes.sample
    end
  end

  def generate_all_codes
    Peg::ALL_PEGS.repeated_permutation(4).map do |pegs|
      Code.new(code: pegs)
    end
  end
end
