require 'pry-byebug'
require_relative './util'
# frozen_string_literal: true

STATE = {
  INITIALIZED: 0,
  ON_GOING: 1,
  FINISHED: 2
}

TIE = 'TIE'
EMPTY_CELL = nil

class TicTacToe
  attr_reader :player1, :player2, :current_turn

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @winner = nil
    @state = STATE[:INITIALIZED]
    @gameboard = Array.new(3) { Array.new(3) { EMPTY_CELL } } # 3x3 game board with all cells set to nil/empty
  end

  def start
    throw Exception('Game has already started') if @state == STATE[:ON_GOING]
    @gameboard = Array.new(3) { Array.new(3, nil) } # 3x3 game board with all cells set to nil/empty
    @current_turn = player1
    @winner = nil
    @state = STATE[:ON_GOING]
  end

  def next_move
    return nil unless @state == STATE[:ON_GOING]

    player = @current_turn
    x, y = input_coords(player)
    @gameboard[x][y] = player.symbol
    @current_turn = @current_turn == player1 ? player2 : player1
  end

  def display_winner
    puts tie? ? 'It was a tie' : "#{@winner.name} won!"
  end

  def finished?
    return true if @state == STATE[:FINISHED]

    if horizontal_win? || vertical_win? || diagonal_win? || tie?
      @state = STATE[:FINISHED]
      @winner = @current_turn == player1 ? player2 : player1 ## the person who made the previous move won the game.
    end
    @state == STATE[:FINISHED]
  end

  def to_s
    display = @gameboard.flat_map do |cell|
      "| #{cell[0] || ' '} | #{cell[1] || ' '} | #{cell[2] || ' '} | \n"
                         end
    display.join('')
  end

  private

  def input_coords(player)
    puts "Please enter next move for #{player.name}"
    coords = gets.split.map { |coord| Integer(coord) - 1 }
    valid_coords?(coords[0], coords[1]) ? coords : input_coords(player) # recursively calls if invalid coords
  rescue ArgumentError
    puts 'coordinates contained non-numeric values'
    input_coords(player)
  end

  def valid_coords?(row, column)
    error_message = nil
    if !row.is_number? || !column.is_number?
      error_message = 'coordinates contained non-numeric values'
    elsif row.nil? || column.nil?
      error_message = '2 arguments expected'
    elsif !row.between?(0, 2) || !column.between?(0, 2)
      error_message = 'coordinates are out of range of the grid'
    elsif coordinate_in_use?(row, column)
      error_message = 'That cell is already in use'
    end

    puts error_message unless error_message.nil?
    error_message.nil?
  end

  def coordinate_in_use?(row, column)
    @gameboard.fetch(row).fetch(column) != EMPTY_CELL
  end

  def horizontal_win?
    @gameboard.any? { |row| row.uniq.size <= 1 && !row.all?(&:nil?) }
  end

  def vertical_win?
    win_found = false
    @gameboard[2].each_with_index do |cell, index|
      if cell != EMPTY_CELL && @gameboard[1][index] == cell && @gameboard[0][index] == cell
        win_found = true
        break
      end
    end
    win_found
  end

  def diagonal_win?
    [@gameboard[0][0], @gameboard[1][1], @gameboard[2][2]].all? { |cell| !cell.nil? && cell == @gameboard[0][0] } ||
      [@gameboard[0][2], @gameboard[1][1], @gameboard[2][0]].all? { |cell| !cell.nil? && cell == @gameboard[0][0] }
  end

  def tie?
    all_cells_filled = @gameboard.all? do |row|
      row.all? { |cell| cell != EMPTY_CELL }
    end

    all_cells_filled && !horizontal_win? && !vertical_win && !diagonal_win?
  end
end
