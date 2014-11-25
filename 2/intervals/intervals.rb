require_relative '../../1/scales_in_guitar/scales'

module Intervals
  STEP_BY_INTERVAL = {
    unison:            0,
    minor_second:      0.5,
    major_second:      1,
    minor_third:       1.5,
    major_third:       2,
    perfect_fourth:    2.5,
    augmented_forth:   3,
    diminished_fifrth: 3,
    tritone:           3,
    perfect_fifth:     3.5,
    minor_sixth:       4,
    major_sixth:       4.5,
    minor_seventh:     5,
    major_seventh:     5.5,
    octave:            6
  }

  INTERVAL_BY_STEP = {
    0.0 => %w(U unison),
    0.5 => %w(m2 minor_second),
    1.0 => %w(M2 major_second),
    1.5 => %w(m3 minor_third),
    2.0 => %w(M3 major_third),
    2.5 => %w(P4 perfect_fourth),
    3.0 => %w(augmented_forth diminished_fifrth tritone A4 D4 TT),
    3.5 => %w(P5 perfect_fifth),
    4.0 => %w(m6 minor_sixth),
    4.5 => %w(M6 major_sixth),
    5.0 => %w(m7 minor_seventh),
    5.5 => %w(M7 major_seventh),
    6.0 => %w(Oct octave)
  }

  ##
  # ==== Description
  #   get the interval given two scales
  #
  # ==== Examples
  #   Intervals.atom(1, 2)
  #   #=> %w(M2 major_second)
  #
  #   Intervals.atom(1, 3)
  #   #=> %w(M3 major_third)
  #
  #   Intervals.atom(b1, 3)
  #   #=> %w(m3 minor_third)
  #
  #   Intervals.atom(6, 2)
  #   #=> %w(P4 perfect_fourth)
  #
  def self.atom(from, to)
    Intervals::Calculator.new(from, to).calculate
  end
end
