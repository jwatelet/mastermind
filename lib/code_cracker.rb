require_relative './rule_engine'
require_relative './peg'
require_relative './display'

class CodeCracker
  def initialize(hash)
    @main_rule_engine = hash[:rule_engine]
    @remaining_guesses = hash[:remaining_guesses]
    @all_codes = generate_all_codes
    @knuth_codes = @all_codes
    @possible_codes = @all_codes
    @display = Dislay.new
  end

  def crack
    is_cracked = false

    until is_cracked
      @display.puts_steps(@remaining_guesses)
      code = get_code
      puts code
      hint = @main_rule_engine.check(code)
      puts hint
      if hint.win?
        is_cracked = true
      else
        prune_list(code, hint)
      end
      @remaining_guesses -= 1
    end
  end

  def minimax
    times_found = Hash.new(0)
    scores = {}
    @possible_codes.each do |code|
      @knuth_codes.each do |code_to_crack|
        score = RuleEngine.new(code: code_to_crack).check(code)
        times_found[score.to_s] += 1
      end
      maximum = times_found.values.max
      scores[code.to_s] = maximum
    end

    minimum = scores.values.max

    @possible_codes.select do |possible_code|
      scores[possible_code.to_s] == minimum
    end
  end

  def prune_list(last_guess, feedback)
    @knuth_codes.select! do |code|
      retrieved_feedback = RuleEngine.new(code: code).check(last_guess)
      retrieved_feedback == feedback
    end
  end

  def get_code
    case @remaining_guesses
    when 12
      Code.new(color_string: 'rrbb')
    else
      guess_codes = minimax
      code = get_guess_code_from_list(@knuth_codes, guess_codes)
      @possible_codes.reject! do |possible_code|
        possible_code.to_s == code.to_s
      end
      code
    end
  end

  def get_guess_code_from_list(knuth_codes, guess_codes)
    knuth_codes.each do |code|
      guess = guess_codes.find { |guess_code| guess_code.to_s == code.to_s }
      return guess unless guess.nil?
    end
    guess_codes.first
  end

  def generate_all_codes
    Peg::ALL_PEGS.repeated_permutation(4).map do |pegs|
      Code.new(code: pegs)
    end
  end
end
