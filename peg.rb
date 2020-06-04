# frozen_string_literal: true

require_relative './colorable.rb'
# Represents a peg on the game board
class Peg
  include Colorable
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    colorize(BACKGROUND_COLORS[color], '  ')
  end
end
