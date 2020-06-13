# frozen_string_literal: true

require_relative './colorable.rb'
require_relative './game_constants.rb'
# Output messages
module Displayable
  include Colorable
  include GameConstants
  SQUARE = '  '

  def title
    puts stylize(BOLD, '----------').center(80)
    puts stylize(BOLD, '|MASTERMIND|').center(80)
    puts stylize(BOLD, '----------').center(80)
  end

  def instructions
    puts <<~HEREDOC
      You get 12 turns to guess the correct pattern.
      P.S.
      If #{COMPUTERS_NAME} plays code-breaker, it can crack the code in #{stylize BOLD, '5 MOVES OR LESS'} ;)

    HEREDOC
  end

  def code_peg_detail
    puts stylize(BOLD, 'Code pegs')
    puts 'These are your options'
  end

  def key_peg_detail
    puts stylize(BOLD, 'Key pegs')
    puts "#{colorize FOREGROUND_COLORS[:r], KEY_PEG_CHARACTER} Red => correct color in correct position."
    puts "#{colorize FOREGROUND_COLORS[:w], KEY_PEG_CHARACTER} White => correct color in wrong position."
    puts
  end

  def show_peg_set(peg_set)
    peg_set.each do |peg|
      print "#{peg} #{SYMBOLS_TO_NAME[peg.color]}".ljust(20) + "(#{peg.color})"
      puts
    end
    puts
  end

  def ask_for_game_mode
    puts <<~HEREDOC
      Will you be playing as the
        (1) Code-maker?
        (2) Code-breaker?
    HEREDOC
  end

  def generating_pattern
    puts "#{COMPUTERS_NAME} is generating a pattern ..."
  end

  def finished_pattern_generation_message
    puts 'Done! The pattern is ready for you to attempt cracking.'
    puts
  end

  def sample_pattern
    SAMPLE_COLORS.each do |color|
      print colorize(FOREGROUND_COLORS[color], color)
    end
  end

  def show_turn(turn)
    puts stylize(BOLD, "Turn ##{turn}")
    sleep 0.5
  end

  def show_pattern(pattern)
    pattern = pattern.map { |number| Peg.new NUMBER_TO_COLOR[number] }
    pattern.each do |peg|
      print peg
      print ' '
    end
  end

  def example
    print 'Example('
    sample_pattern
    print '): '
  end

  def ask_for_secret_pattern
    print 'Enter your 4-color secret pattern. '
    example
  end

  def ask_for_guess_message
    print 'Take a 4-color guess. '
    example
  end

  def print_key_pegs(feedback)
    feedback.each do |peg|
      print peg
      print ' ' unless peg == feedback.last
    end
  end

  def show_feedback_message(game_mode, feedback)
    if game_mode == 1
      print '  |||  Feedback he got => '
    else
      print '  |||  Feedback you got => '
    end

    print_key_pegs feedback
    2.times { puts }
  end

  def game_over_cracked(game_mode)
    if game_mode == 1
      puts "#{COMPUTERS_NAME} beat you in 5 moves or less.", "Yeah he's smart..."
    else
      puts "Great job, you broke #{COMPUTERS_NAME}'s code in less than 12 moves.", 'Not bad...'
    end
  end

  def game_over_lost
    puts "Yikes... you really lost against a computer? C'mon try again!"
  end
end
