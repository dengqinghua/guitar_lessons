require_relative 'intervals'

module Interval
  class Calculator
    NATURAL_SCALE_REX   = %r|\A([1-7])\Z|
    UNNATURAL_SCALE_REX = %r|\A([b#])([1-7])\Z|
    DIM_SCALE_REX       = %r|\Ab\Z|
    AUG_SCALE_REX       = %r|\A#\Z|

    ##
    # ==== Description
    #   given two scales, return the interval existed by
    # these scales.
    #
    #   @deviations is the deviation of 'b', '#' kind scale.
    #
    # ==== Parameters
    #   from: the lower scale
    #   to:   the higher scale
    #
    # ==== Examples
    #   Interval::Calculator.new(3, 4)
    #   #=> #<Interval::Calculator @from=3, @two=4, @deviations=0>
    #
    #   Interval::Calculator.new('b3', 4)
    #   #=> #<Interval::Calculator @from=3, @two=4, @deviations=-0.5>
    #
    #   Interval::Calculator.new('b3', '#7')
    #   #=> #<Interval::Calculator @from=3, @two=7, @deviations=-1.0>
    #
    def initialize(from, to)
      @from, @to, @deviations = normalize_scales(from: from, to: to)
    end

    ##
    # ==== Description
    #  calculate the intervals using @from, @to, @deviations
    #
    # ==== Examples
    #
    #  Interval::Calculator.new('b3', '7').calculate
    #  =>
    #    [
    #      "augmented_forth",
    #      "diminished_fifrth",
    #      "tritone",
    #      "A4",
    #      "D4",
    #      "TT"
    #    ]
    #
    def calculate
      Intervals::INTERVAL_BY_STEP[calculate_step]
    end

    def calculate_step
      if @to < @from
        @to += 7

        if [7, 8].all? { |scale| (@from..@to).include? scale }
          @deviations -= 0.5
        end

        if [10, 11].all? { |scale| (@from..@to).include? scale }
          @deviations -= 0.5
        end
      end

      if [3, 4].all? { |scale| (@from..@to).include? scale }
        @deviations -= 0.5
      end

      step = (@to - @from + @deviations).to_f

      step < 0 ? step += 6 : step
      step > 6 ? step -= 6 : step # For now
    end

    private
    ##
    # ==== Description
    #   seperate 'b', '#' out of 'b2', '#3', and calculate
    # the deviations caused by '#' and 'b'
    #
    def normalize_scales(options)
      from_string = options[:from].to_s.strip
      to_string   = options[:to].to_s.strip

      deviations = 0

      if NATURAL_SCALE_REX.match(from_string)
        from = from_string
      elsif unnatural_rex = UNNATURAL_SCALE_REX.match(from_string)
        dim_or_aug, from = unnatural_rex.captures

        DIM_SCALE_REX.match(dim_or_aug) ? deviations += 0.5 : deviations -= 0.5
      else
        raise "#{from} is not recognized."
      end

      if NATURAL_SCALE_REX.match(to_string)
        to = to_string
      elsif unnatural_rex = UNNATURAL_SCALE_REX.match(to_string)
        dim_or_aug, to = unnatural_rex.captures

        DIM_SCALE_REX.match(dim_or_aug) ? deviations -= 0.5 : deviations += 0.5
      else
        raise "#{to} is not recognized."
      end

      [from.to_i, to.to_i, deviations]
    end
  end
end
