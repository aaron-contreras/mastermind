# frozen_string_literal: true

require_relative './displayable.rb'
require_relative './colorable.rb'
require_relative './peg.rb'
require_relative './code_breaker.rb'
require_relative './code_maker.rb'
# Mastermind Game
class Game
  include Displayable
  include Colorable
  
  attr_accessor :turns
  attr_reader :code_maker, :code_breaker

  def initialize
    intro
    generating_pattern
    # @code_maker = CodeMaker.new available_code_pegs
    @code_maker = CodeMaker.new code_peg_colors
    p code_maker.pattern
    finished_pattern_generation
    @code_breaker = CodeBreaker.new
    @turns = 12
  end

  def intro
    title
    instructions
    peg_options
  end

  def build_peg_set(type)
    set_of_pegs = type.collect {|color| Peg.new color}
  end

  def available_code_pegs
    build_peg_set code_peg_colors
  end

  def available_key_pegs
    build_peg_set key_peg_colors
  end

  def peg_options
    code_peg_detail
    show_peg_set available_code_pegs
    key_peg_detail
  end

  def cracked?
    @code_breaker.guess == @code_maker.pattern
  end

  def no_more_turns?
    turns.zero?
  end

  def guess
    guess_attempt = nil
    until CodeBreaker.valid_guess? guess_attempt, code_peg_colors
      guess_attempt = gets.chomp
    end
    guess_attempt.split('').map(&:to_sym)
  end

  def game_over_message
    return game_over_cracked if cracked?
    return game_over_lost if no_more_turns?
  end

  def play
    until cracked? || no_more_turns?
      ask_for_guess_message
      code_breaker.guess = guess
      code_maker.provide_feedback code_breaker.guess
      self.turns -= 1
    end
    game_over_message
  end
end

Game.new.play