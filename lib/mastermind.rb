require_relative './peg'
require_relative './rule_engine'
require_relative './display'

class Mastermind
  attr_accessor :rule_engine, :steps

  MODE_GUESSER = 'GUESSER'.freeze
  MODE_CHECKER = 'CHECKER'.freeze

  def initialize
    @steps = 12
    @display = Dislay.new
  end

  def start
    @display.puts_general_instructions
    @display.puts_mode_instructions
    if gets_mode == MODE_GUESSER
      play_guesser
    else
      play_ckecker
    end
  end

  def play_ckecker
    @display.puts_checker_instruction
    @display.puts_pegs_letters
    code = gets_user_code
    self.rule_engine = RuleEngine.new(code: code)
    checker_game_loop
  end

  def play_guesser
    self.rule_engine = RuleEngine.new
    @display.puts_pegs_letters
    @display.puts_hint_letters
    guesser_game_loop
    @display.puts_victory_or_defeat(@steps)
  end

  def guesser_game_loop
    loop do
      @display.puts_guess_instructions
      @display.puts_steps(@steps)
      guess = gets_user_code
      puts guess
      hints = rule_engine.check(guess)
      puts hints.join(' ')
      @steps -= 1
      break if rule_engine.win?(hints) || @steps.zero?
    end
  end

  def checker_game_loop
    loop do
      code = Code.new
      puts code
      hints = rule_engine.check(code)
      puts hints.join(' ')
      @steps -= 1
      break if @steps.zero? || rule_engine.win?(hints)
    end
  end

  def gets_mode
    mode_string = ''
    loop do
      validate = false
      mode_string = gets.chomp

      if %w[1 2].include?(mode_string)
        validate = true
      else
        @display.puts_only_1_or_2_error
        @display.puts_mode_instructions
      end

      break if validate
    end

    case mode_string
    when '1'
      MODE_GUESSER
    when 2
      MODE_CHECKER
    end
  end

  def gets_user_code
    guess_string = ''
    loop do
      validate = false
      guess_string = gets.chomp.downcase

      if guess_string.match?(/^[rgypbw]+$/) && guess_string.length == 4
        validate = true
      else
        @display.puts_only_4_caracters_error
        @display.puts_pegs_letters
      end
      break if validate
    end

    Code.new(color_string: guess_string)
  end
end