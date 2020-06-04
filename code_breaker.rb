# frozen_string_literal: true

# Player who attempts to decipher the pattern
require 'pry'
class CodeBreaker
  attr_accessor :guess

  def initialize
    @guess = nil
  end

  def self.valid_guess?(guess, peg_set)
    return false if guess.nil?

    pegs = guess.split('').collect(&:to_sym)
    pegs.all? { |peg| peg_set.include? peg}
  end
end