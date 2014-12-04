require_relative 'intervals'

class IntervalGuesser
  attr_reader :from, :to, :intervals

  ##
  # ==== Description
  #   IntervalGuesser.new(has_deviation: 'r')
  #
  def initialize(has_deviation:)
    @from = rand(1..7).to_s
    @to   = rand(1..7).to_s

    if has_deviation == 'r'
      @from = ['#', 'b', ''].sample + @from
      @to   = ['#', 'b', ''].sample + @to
    end

    @intervals = Intervals.atom(from, to)
  end

  def guess!
    puts "#{from}-#{to}"

    loop do
      interval_guess = $stdin.gets.strip

      if intervals.include?(interval_guess)
        puts 'Yep!'
        break
      else
        puts 'NOPE!'
      end
    end
  end
end
