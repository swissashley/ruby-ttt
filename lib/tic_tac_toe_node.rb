require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?

      return false if @board.winner.nil? || evaluator == @board.winner
      return true if @board.winner != evaluator
      
    end
    #recursive cases
    if @next_mover_mark == evaluator  # player's turn
      return children.all? {|child| child.losing_node?(evaluator)}
    else  # opponent's turn
      return children.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false if @board.winner.nil? || evaluator != @board.winner
    end
    #recursive cases
    if @next_mover_mark == evaluator  # player's turn
      return children.any? {|child| child.winning_node?(evaluator)}
    else  # opponent's turn
      return children.all? {|child| child.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_states = []
    @next_mover_mark == :o ? next_mover_mark = :x : next_mover_mark = :o
    # byebug
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell.nil?
          curr_board = @board.dup
          curr_board[[i,j]] = @next_mover_mark
          next_node = TicTacToeNode.new(curr_board, next_mover_mark , [i,j])
          next_states << next_node
        end
      end
    end
    next_states

  end

end
