class Code < Peg
  def to_s
    colorize(BACKGROUND_COLORS[color], CODE_PEG_CHARACTER) 
  end
end