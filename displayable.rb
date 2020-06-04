# frozen_string_literal: true

require 'pry'
require_relative './colorable.rb'
# Output messages
module Displayable
  include Colorable
  SQUARE = '  '.freeze

  def title
    puts
    puts 'MASTERMIND'.center 80
    puts '----------'.center 80
    puts
  end

  def instructions
    puts "Play detective in this fun puzzle. You get 12 turns to guess the correct pattern. The codebreaker is provided feedback on how good his guess is after each turn.\n"
    puts
  end

  def code_peg_detail
    puts 'Code pegs'
    puts 'These are your options'
  end

  def key_peg_detail
    puts 'Key pegs'
    puts "#{colorize BACKGROUND_COLORS[:w], SQUARE} White indicates correct color in correct position."
    puts "#{colorize BACKGROUND_COLORS[:bl], SQUARE} Black indicates correct color in wrong position."
  end

  def show_peg_set(peg_set)
    peg_set.each {|peg| print peg}
    puts
  end

  def generating_pattern
    puts 'Computer is generating the pattern to crack'
    # sleep(2)
  end

  def finished_pattern_generation
    puts 'Done!'
  end

  def sample_pattern
    SAMPLE_COLORS.each do |color|
      print "#{colorize(FOREGROUND_COLORS[color], color)}"
    end
  end

  def ask_for_guess_message
    print 'Take a guess in the format '
    sample_pattern
    print " In which each letter represents a peg's color"
  end

  def game_over_cracked
    puts 'Great job, you broke the code'
  end

  def game_over_lost
    puts "Yikes... you really lost against a computer? C'mon try again!"
  end
end