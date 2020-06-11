# frozen_string_literal: true

require_relative './colorable.rb'
require_relative './code_maker.rb'
require_relative './consultant.rb'
# Player who attempts to decipher the pattern
class CodeBreaker
  include Colorable
  attr_accessor :guess, :unused_guesses, :remaining_possibilities
  attr_reader :consultant

  STARTING_GUESS = [1, 1, 2, 2].freeze

  def initialize
    @guess = nil
    @unused_guesses = create_set_of_possibilities
    @remaining_possibilities = create_set_of_possibilities
    @consultant = Consultant.new
  end

  def create_set_of_possibilities
    [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
  end

  def all_black_key_pegs(feedback)
    feedback.all? { |peg| peg.color == :bl }
  end

  def solved?(feedback)
    feedback.length == 4 && all_black_key_pegs(feedback)
  end

  def solve(feedback, turn)
    return self.guess = unused_guesses.delete(STARTING_GUESS) if turn == 1
    return if solved? feedback

    self.remaining_possibilities = consultant.possibilities_to_keep remaining_possibilities, guess, feedback

    guess = consultant.find_next_guess unused_guesses, remaining_possibilities

    unused_guesses.delete(guess)
  end
end
