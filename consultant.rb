# frozen_string_literal: true

require_relative './colorable'
# A helper for the CodeBreaker that knows how to pick a next guess
class Consultant < CodeMaker
  include Colorable

  POSSIBLE_PEG_SCORES = [
    [0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
    [1, 0], [1, 1], [1, 2], [1, 3], [2, 0],
    [2, 1], [2, 2],
    [3, 0],
    [4, 0]
  ].freeze

  def initialize; end

  def possibilities_to_keep(remaining_possibilities, guess, feedback)
    remaining_possibilities.select do |possibility|
      colors(feedback) == colors(determine_peg_correctness(guess, possibility))
    end
  end

  def all_possible_peg_feedback
    POSSIBLE_PEG_SCORES.map do |score|
      black_pegs = score[0]
      white_pegs = score[1]
      peg_container = []
      black_pegs.times { peg_container.push Peg.new(:bl) }
      white_pegs.times { peg_container.push Peg.new(:w) }
      peg_container
    end
  end

  def minimum_score_for_guess(guess, remaining_possibilities)
    all_possible_peg_feedback.map do |feedback|
      remaining_possibilities.count - possibilities_to_keep(remaining_possibilities, guess, feedback).count
    end.min
  end

  def build_info_hash(unused_guesses, remaining_possibilities)
    unused_guesses.each_with_object({}) do |guess, results|
      results[guess] = [
        minimum_score_for_guess(guess, remaining_possibilities),
        remaining_possibilities.include?(guess)
      ]
    end
  end

  def find_next_guess(unused_guesses, remaining_possibilities)
    processed_guesses = build_info_hash unused_guesses, remaining_possibilities

    set_of_minimum_scores = processed_guesses.values.map { |result| result[0] }
    maximum_from_minimum_scores = set_of_minimum_scores.max

    best_guess processed_guesses, maximum_from_minimum_scores
  end

  def find_optimal_guess(processed_guesses, maximum_from_minimum_scores)
    processed_guesses.find do |_pattern, value|
      score = value[0]
      included_in_set = value[1]
      score == maximum_from_minimum_scores && included_in_set
    end
  end

  def find_smallest_numeric_guess(processed_guesses, maximum_from_minimum_scores)
    processed_guesses.find do |_pattern, value|
      score = value[0]
      score == maximum_from_minimum_scores
    end
  end

  def best_guess(processed_guesses, maximum_from_minimum_scores)
    optimal_guess = find_optimal_guess(processed_guesses, maximum_from_minimum_scores) ||
                    find_smallest_numeric_guess(processed_guesses, maximum_from_minimum_scores)

    optimal_guess[0]
  end
end
