class Guess < Code
  def initialize(string)
    super()
    @pegs = string.split('').map do |char|
      Peg.create(char)
    end
  end
end
