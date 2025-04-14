# frozen_string_literal: true

STATE = {
  INITIALIZED: 0,
  ON_GOING: 1,
  FINISHED: 2
}

EMPTY_CELL = nil

class TicTacToe
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @state = STATE[:INITIALIZED]
    @gameboard = Array.new(3) { Array.new(3) { EMPTY_CELL } } # 3x3 game board with all cells set to nil/empty
  end

  def start
    throw Exception('Game has already started') if @state == STATE[:ON_GOING]
    @gameboard = Array.new(3) { Array.new(3) { nil } } # 3x3 game board with all cells set to nil/empty
    @current_turn = player1
    @state = STATE[:ON_GOING]
  end

  def next_move
    player = @current_turn
    coords = input_coords(player)
    @gameboard[coords[0]][coords[1]] = player.symbol
    @current_turn = @current_turn == player1 ? player2 : player1
  end

  def finished?
    game_finished = @state == STATE[:FINISHED] || horizontal_win? || vertical_win? || diagonal_win? || tie?
    @state = STATE[:FINISHED] if game_finished
    game_finished
  end

  private

  def input_coords(player) # rubocop:disable Metrics/MethodLength
    coords = nil
    begin
      puts "Please enter next move for #{player.name}"
      coords = gets.split.map(&:to_i)
      puts 'That cell is already in use' if @gameboard[coords[0]][coords[1]] != EMPTY_CELL
    rescue ArgumentError
      puts 'coordinates contained non-numeric values'
    rescue IndexError
      puts 'coordinates are out of range of the grid [0 - 3]'
    end

    return coords unless coords.nil?

    input_coords(player)
  end

  def horizontal_win?
    @gameboard.any? { |row| row.uniq.size <= 1 && !row.all?(&:nil?) }
  end

  def vertical_win?
    @gameboard[2].each_with_index do |cell, index|
      break true if cell != EMPTY_CELL && @gameboard[1][index] == cell && @gameboard[0][index] == cell
    end
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
