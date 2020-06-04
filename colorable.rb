# frozen_string_literal: true

# Modify output with colors and formatting
module Colorable
  FOREGROUND_COLORS = {
    bl: 30,
    r: 31,
    g: 32,
    y: 33,
    b: 34,
    m: 35,
    c: 36,
    w: 37
  }.freeze

  BACKGROUND_COLORS = {
    bl: 40,
    r: 41,
    g: 42,
    y: 43,
    b: 44,
    m: 45,
    c: 46,
    w: 47
  }.freeze

  SAMPLE_COLORS = [:r, :g, :y, :b].freeze

  KEY_COLORS = Proc.new { |color, value| color == :bl || color == :w }

  def code_peg_colors
    FOREGROUND_COLORS.each_key.reject(&KEY_COLORS)
  end

  def key_peg_colors
    FOREGROUND_COLORS.each_key.select(&KEY_COLORS)
  end

  def colorize(color, string)
    "\e[#{color}m#{string}\e[0m"
  end

  def stylize(style, string)
    "\e[#{style}m#{string}\e[0m"
  end
end