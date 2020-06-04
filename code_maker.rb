# frozen_string_literal: true

require_relative './peg.rb'
class CodeMaker
  attr_reader :pattern
  def initialize(color_set)
   @pattern = generate_pattern color_set
  end

  def generate_pattern(color_set)
    color_set.sample 4
  end

  def correct_color?(pattern_checker, peg)
    pattern_checker.include? peg
  end

  def correct_position?(pattern_checker, index, peg)
    pattern_checker[index] == peg
  end

  def determine_peg_correctness(guess)
    feedback = []
    pattern_checker = pattern.map { |peg| peg }
    guess.each_with_index do |peg, index|
      if correct_color? pattern_checker, peg
        if correct_position? pattern_checker, index, peg
          feedback << Peg.new(:bl)
          pattern_checker[index] = nil
          next
        end
        feedback << Peg.new(:w)
      end
    end
    binding.pry
    feedback
  end

  def check_breakers_guess(guess)
    determine_peg_correctness(guess)
  end

  def provide_feedback(guess)
    check_breakers_guess(guess).each { |key_peg| print key_peg}
    puts
  end
end