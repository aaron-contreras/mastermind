# frozen_string_literal: true

# Represents the code pegs that build a pattern
class Code < Peg
  def to_s
    colorize(BACKGROUND_COLORS[color], CODE_PEG_CHARACTER)
  end
end
