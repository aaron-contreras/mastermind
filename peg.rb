# frozen_string_literal: true

require_relative './colorable.rb'
# Represents a peg on the game board
class Peg
  include Colorable
  attr_reader :color, :number

  def initialize(color)
    @color = color
    @number = COLOR_TO_NUMBER[color]
  end

  def self.valid_pattern?(pattern_attempt, peg_set)
    return false if pattern_attempt.nil?

    pegs = pattern_attempt.split('').map(&:to_sym)
    pegs.length == 4 && pegs.all? { |color| peg_set.include? color }
  end

  def to_s
    if code_peg_colors.include? color
      colorize(BACKGROUND_COLORS[color], CODE_PEG_CHARACTER)
    else
      colorize(FOREGROUND_COLORS[color == :bl ? :r : color], KEY_PEG_CHARACTER)
    end
  end
end
