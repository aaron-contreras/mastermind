# frozen_string_literal: true

require_relative './colorable.rb'
module Code
  def peg_colors
    FOREGROUND_COLORS.reject { |color, value| color == :b || color == :w }
  end
end
