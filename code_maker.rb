# frozen_string_literal: true

require_relative './peg.rb'
require_relative './colorable.rb'
# Player who has the secret code
class CodeMaker
  attr_reader :pattern, :is_player
  attr_accessor :feedback

  include Colorable
  include Displayable

  def initialize(is_player, set)
    @is_player = is_player
    @pattern = assign_pattern set
    @feedback = nil
  end

  def assign_pattern(set)
    if is_player
      set
    else
      generate_pattern set
    end
  end

  def generate_pattern(set)
    set.sample(4)
  end

  def correct_color?(pattern_checker, peg)
    pattern_checker.include? peg
  end

  def correct_position?(pattern_checker, index, peg)
    pattern_checker[index] == peg
  end

  def find_total_number_of_hits(guess, pattern_checker)
    [1, 2, 3, 4, 5, 6].reduce(0) do |total_matches, current_peg|
      total_matches + [pattern_checker.count(current_peg), guess.count(current_peg)].min
    end
  end

  def find_number_of_black_pegs(guess, pattern_checker)
    black_peg_count = 0
    guess.each_with_index do |peg, index|
      black_peg_count += 1 if correct_position? pattern_checker, index, peg
    end
    black_peg_count
  end

  def determine_peg_correctness(guess, provided_pattern)
    feedback = []
    pattern_checker = provided_pattern.map { |peg| peg }
    hits = find_total_number_of_hits guess, pattern_checker
    number_of_black_pegs = find_number_of_black_pegs(guess, pattern_checker)
    number_of_black_pegs.times { feedback << Peg.new(:bl) }
    number_of_white_pegs = hits - number_of_black_pegs
    number_of_white_pegs.times { feedback << Peg.new(:w) }
    feedback
  end

  def determine_feedback(game_mode, guess, provided_pattern)
    self.feedback = determine_peg_correctness(guess, provided_pattern)
    show_feedback_message game_mode, feedback
  end
end
