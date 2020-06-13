# frozen_string_literal: true

# Represents the feedback pegs for a given pattern
class Key < Peg
  def to_s
    colorize(FOREGROUND_COLORS[color], KEY_PEG_CHARACTER)
  end
end
