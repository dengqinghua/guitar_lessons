require_relative 'interval_guesser'

puts 'Begin to guess interval'
12.times do |time|
  puts "== Guess #{time + 1} =="
  guesser = IntervalGuesser.new(has_deviation: ARGV.first)
  guesser.guess!
end
