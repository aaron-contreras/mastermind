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

  COLOR_TO_NUMBER = {
    r: 1,
    g: 2,
    y: 3,
    b: 4,
    m: 5,
    c: 6
  }.freeze

  NUMBER_TO_COLOR = {
    1 => :r,
    2 => :g,
    3 => :y,
    4 => :b,
    5 => :m,
    6 => :c
  }.freeze

  SYMBOLS_TO_NAME = {
    r: 'Red',
    g: 'Green',
    y: 'Yellow',
    b: 'Blue',
    m: 'Magenta',
    c: 'Cyan'
  }.freeze

  KEY_PEG_CHARACTER = "\u29bb"
  CODE_PEG_CHARACTER = '  '

  SAMPLE_COLORS = %i[r g y b].freeze

  KEY_COLORS = proc { |color, _value| %i[bl w].freeze.include? color }

  BOLD = 1

  def colors(pattern)
    pattern.map(&:color)
  end

  def code_peg_numbers
    COLOR_TO_NUMBER.map { |_key, value| value }
  end

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
