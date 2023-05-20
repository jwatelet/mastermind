class Peg
  RED = "\033[31m●\033[0m".freeze
  GREEN = "\033[32m●\033[0m".freeze
  YELLOW = "\033[33m●\033[0m".freeze
  BLUE = "\033[34m●\033[0m".freeze
  PINK = "\033[35m●\033[0m".freeze
  WHITE = "\033[37m●\033[0m".freeze

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

class Computer
  attr_reader :code

  def initialize
    @code = Code.new
  end

  def check(guess)
    guess.each_with_index.map do |peg, index|
      if peg == @code.pegs[index]
        Peg::RIGHT_PLACE
      elsif @code.pegs.include?(peg)
        Peg::RIGHT_COLOR
      end
    end.compact
  end

  def win?(hints)
    hints.all? { |peg| peg == Peg::RIGHT_PLACE }
  end
end

class Code
  attr_reader :pegs

  def initialize
    @pegs = [Peg::RED, Peg::GREEN, Peg::YELLOW, Peg::BLUE, Peg::PINK, Peg::WHITE].shuffle.take(4)
  end

  def to_s
    @pegs.join(' ')
  end
end

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

      puts guess.join(' ')
      hints = @computer.check(guess)
      puts hints.join(' ')
      @steps -= 1
      puts @computer.win?(hints)
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
    guess = ''
    loop do
      validate = false
      guess = gets.chomp.downcase

      if guess.match?(/^[rgypbw]+$/) && guess.length == 4
        validate = true
      else
        puts "\033[31mEnter only 4 letters caracters\033[0m"
        show_pegs_letters
      end
      break if validate
    end

    guess.split('').map do |char|
      Peg.create(char)
    end
  end

  def show_steps
    puts "#{@steps} guesses left"
  end
end

mastermind = Mastermind.new
mastermind.start
