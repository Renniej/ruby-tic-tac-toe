# Business logic
# Enter player 1's name
# Enter player 2's name
#
# While the game is not a tie or has a winner
#   ask the next player where they would like to place their symbol
#     if the that cell is already full, inform the player and ask them to choose again.
#   after the move check for these win conditions
#       left diagonal
#       right diagonal
#       horizontal
#       vertical
#   if a win or tie condition exist then exit the game
#   output winner or if it was a tie
#
#
#
# class Player(name, symbol)
#

#
#
#
# Create a variable of type Player named player_1 with the initial parameters of the user's input and "X"
# Create a variable of type Player named player_2 with the initial parameters of the user's input and "O"
# Create a variable called tic_tac_toe of type TicTacToe with the initial parameters of player_1 and player_2
#
#  call game.start()
#
# While the game.state is ON_GOING
#    game.getInputFromPlayer()
#    game.checkForWinConditions()
# end
#
require_relative 'Player'
require_relative 'tic_tac_toe'

def input_players
  puts "Enter player 1's name"
  player1 = Player.new(gets.chomp, 'X')
  puts "Enter player 2's name"
  player2 = Player.new(gets.chomp, 'O')
  [player1, player2]
end

def main
  player1, player2 = input_players
  game = TicTacToe.new(player1, player2)
  game.start
  puts game
  until game.finished?
    game.next_move
    puts game
  end
end

main
