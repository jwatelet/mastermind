require_relative './peg'

class Dislay
  def puts_general_instructions
    puts "\e[4mMastermind!\e[0m".center(80)
    puts 'The object of MASTERMIND (r) is to guess a secret code consisting of a series of 4 colored pegs.'
    puts 'Each guest results in feedback narrowing down the possibilities of the code.'
    puts 'The winner is the player who solves his opponent\'s secret code with fewer guesses.'
  end

  def puts_mode_instructions
    puts 'To be the guesser type 1'
    puts 'To be the checker type 2'
  end

  def puts_checker_instruction
    puts 'Enter the code the computer will guess:'
    puts 'The code is 4 colors long'
  end

  def puts_victory_or_defeat(steps)
    if steps.zero?
      puts "you did not have guess the right code in 12 steps, game over :'()"
    else
      puts 'YOU WIN'
    end
  end

  def puts_guess_instructions
    puts 'Enter 4 letters to guess the code:'
  end

  def puts_pegs_letters
    puts 'To chose a peg type the first letter of the color:'
    puts "- #{Peg::RED}: R"
    puts "- #{Peg::GREEN}: G"
    puts "- #{Peg::YELLOW}: Y"
    puts "- #{Peg::PINK}: P"
    puts "- #{Peg::BLUE}: B"
    puts "- #{Peg::WHITE}: W"
  end

  def puts_hint_letters
    puts 'This are also symbols to help you after a guess:'
    puts "- #{Peg::RIGHT_COLOR}: You have a right color, but not at the right place"
    puts "- #{Peg::RIGHT_PLACE}: Right place and right color"
  end

  def puts_steps(steps)
    if steps > 1
      puts "#{steps} guesses left"
    else
      puts "#{steps} guess left"
    end
  end

  def puts_only_1_or_2_error
    puts "\033[31mPlease enter only 1 or 2\033[0m"
  end

  def puts_only_4_caracters_error
    puts "\033[31mEnter only 4 letters caracters\033[0m"
  end
end
