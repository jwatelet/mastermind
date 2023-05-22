require_relative './peg'
require_relative './computer'
require_relative './guess'

class Mastermind
  def initialize
    @computer = Computer.new
    @steps = 12
  end

  def start
    show_general_instructions
    show_pegs_letters
    show_hint_letters

    loop do
      show_user_instructions
      show_steps
      guess = gets_user_guess

      puts guess
      hints = @computer.check(guess)
      puts hints.join(' ')
      @steps -= 1
      break if @computer.win?(hints) || @steps.zero?
    end

    if @steps.zero?
      puts "you did not have guess the right code in 12 steps, game over :'()"
    else
      puts 'YOU WIN'
    end
  end

  def show_general_instructions
    puts "\e[4mMastermind!\e[0m".center(80)
    puts 'The object of MASTERMIND (r) is to guess a secret code consisting of a series of 4 colored pegs.'
    puts 'Each guest results in feedback narrowing down the possibilities of the code.'
    puts 'The winner is the player who solves his opponent\'s secret code with fewer guesses.'
  end

  def show_pegs_letters
    puts 'To chose a peg type the first letter of the color:'
    puts "- #{Peg::RED}: R"
    puts "- #{Peg::GREEN}: G"
    puts "- #{Peg::YELLOW}: Y"
    puts "- #{Peg::PINK}: P"
    puts "- #{Peg::BLUE}: B"
    puts "- #{Peg::WHITE}: W"
  end

  def show_hint_letters
    puts 'This are also symbols to help you after a guess:'
    puts "- #{Peg::RIGHT_COLOR}: You have a right color, but not at the right place"
    puts "- #{Peg::RIGHT_PLACE}: Right place and right color"
  end

  def show_user_instructions
    puts 'Enter 4 letters to guess the code:'
  end

  def gets_user_guess
    guess_string = ''
    loop do
      validate = false
      guess_string = gets.chomp.downcase

      if guess_string.match?(/^[rgypbw]+$/) && guess_string.length == 4
        validate = true
      else
        puts "\033[31mEnter only 4 letters caracters\033[0m"
        show_pegs_letters
      end
      break if validate
    end

    Guess.new(guess_string)
  end

  def show_steps
    if @steps > 1
      puts "#{@steps} guesses left"
    else
      puts "#{@steps} guess left"
    end
  end
end
