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
    3.0 => %w(augmented_forth diminished_fifrth tritone A4 D5 TT),
    3.5 => %w(P5 perfect_fifth),
    4.0 => %w(m6 minor_sixth),
    4.5 => %w(M6 major_sixth),
    5.0 => %w(m7 minor_seventh),
    5.5 => %w(M7 major_seventh),
    6.0 => %w(Oct octave)
  }

  MAP = {
    U:  [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]], # step: 0.0
    m2: [[3, 4], [7, 1]],                                         # step: 0.5
    M2: [[1, 2], [2, 3], [4, 5], [5, 6], [6, 7]],                 # step: 1.0
    m3: [[2, 4], [3, 5], [6, 1], [7, 2]],                         # step: 1.5
    M3: [[1, 3], [4, 6], [5, 7]],                                 # step: 2.0
    P4: [[1, 4], [2, 5], [3, 6], [5, 1], [6, 2], [7, 3]],         # step: 2.5
    A4: [[4, 7]],                                                 # step: 3.0
    D5: [[7, 4]],                                                 # step: 3.0
    P5: [[1, 5], [2, 6], [3, 7], [4, 1], [5, 2], [6, 3]],         # step: 3.5
    m6: [[3, 1], [6, 4], [7, 5]],                                 # step: 4.0
    M6: [[1, 6], [2, 7], [4, 2], [5, 3]],                         # step: 4.5
    m7: [[2, 1], [3, 2], [5, 4], [6, 5], [7, 6]],                 # step: 5.0
    M7: [[1, 7], [4, 3]]                                          # step: 5.5
    #Oct: [[...]],                                                # step: 6.0
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
