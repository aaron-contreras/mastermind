# frozen_string_literal: true

require_relative './game_constants.rb'
require_relative './displayable.rb'
require_relative './colorable.rb'
require_relative './peg.rb'
require_relative './code.rb'
require_relative './code_breaker.rb'
require_relative './code_maker.rb'
# Mastermind Game
class Game
  include GameConstants
  include Displayable
  include Colorable

  attr_accessor :turn
  attr_reader :game_mode, :code_maker, :code_breaker, :computers_name

  def initialize
    title
    instructions
    peg_options
    @game_mode = game_mode_setting
    create_players
    @turn = 0
  end

  def build_peg_set(type)
    type.collect { |color| Code.new color }
  end

  def peg_options
    code_peg_detail
    show_peg_set build_peg_set(code_peg_colors)
    key_peg_detail
  end

  def game_mode_setting
    ask_for_game_mode
    mode = gets.chomp.to_i until GAME_MODES.key? mode
    puts
    mode
  end

  def create_human_code_maker
    ask_for_secret_pattern
    @code_maker = CodeMaker.new GAME_MODES[game_mode], obtain_pattern
    print 'This is your selected pattern =>'.ljust(35)
    show_pattern code_maker.pattern
    2.times { puts }
  end

  def create_computer_code_maker
    generating_pattern
    sleep 1
    @code_maker = CodeMaker.new GAME_MODES[game_mode], code_peg_numbers
    finished_pattern_generation_message
  end

  def create_players
    if game_mode == 1
      create_human_code_maker
    else
      create_computer_code_maker
    end

    @code_breaker = CodeBreaker.new
  end

  def cracked?
    @code_breaker.guess == @code_maker.pattern
  end

  def no_more_turns?
    turn == 12
  end

  def convert_to_numbers(guess)
    guess.split('').map(&:to_sym).map { |color| COLOR_TO_NUMBER[color] }
  end

  def obtain_pattern
    pattern = gets.chomp until Peg.valid_pattern? pattern, code_peg_colors
    puts
    convert_to_numbers pattern
  end

  def game_over_message
    return game_over_cracked(game_mode) if cracked?

    game_over_lost if no_more_turns?
    print "Here's what #{COMPUTERS_NAME} secret code was => "
    show_pattern code_maker.pattern
  end

  def human_code_breaker
    ask_for_guess_message
    code_breaker.guess = obtain_pattern
    print 'You guessed =>  '
  end

  def computer_code_breaker
    puts "#{COMPUTERS_NAME} is thinking..."
    sleep 1
    code_breaker.guess = code_breaker.solve code_maker.feedback, turn
    print "#{COMPUTERS_NAME} guessed =>  "
  end

  def generate_guess
    computer_code_breaker if game_mode == 1
    human_code_breaker if game_mode == 2
  end

  def run_game_loop
    self.turn += 1
    show_turn turn
    generate_guess
    show_pattern code_breaker.guess
    code_maker.determine_feedback game_mode, code_breaker.guess, code_maker.pattern
  end

  def play
    run_game_loop until cracked? || no_more_turns?
    game_over_message
  end
end
