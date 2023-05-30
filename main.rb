require_relative './lib/mastermind'
require_relative './lib/code'
require_relative './lib/code_cracker'
require_relative './lib/rule_engine'
# mastermind = Mastermind.new
# mastermind.start

# require_relative './lib/code'

# code_cracker = CodeCracker.new(rule_engine)

# puts code_cracker.crack

# code = Code.new(color_string: 'grrr')
code = Code.new(color_string: 'rrwy')
# code = Code.new(color_string: 'rbbr')
puts code
# guess = Code.new(color_string: 'rwww')
guess = Code.new(color_string: 'brrp')
# guess = Code.new(color_string: 'rbbb')
puts guess

rule_engine = RuleEngine.new(code: code)

puts rule_engine.check(guess)
