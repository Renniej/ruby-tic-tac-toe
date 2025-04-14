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
# class Game
#   - board : 2D array (3 columns x 3 rows ) with all initial value in rows being nil
#   - State variable of with enums INTIIALIZED, ON_GOING, FINISHED with initial value being INITIALIZED
#   - player_1 = player_1
#   - player_2 = player_2
#   - currentTurn = player1
#
#   start()
#     if game is already ongoing then throw an error
#     set state variable to ON_GOING
#     set all values in 2D array to nil
#     set currentTurn to player1
#
#    getInputFromPlayer()
#       player = currentTurn
#       ask player to input coordinates for their move (2 2)
#       if the coordinates are not numbers or invalid range ask them to reinput them
#       else if board[input] is not nil then inform player that the cell is already filled
#       else set board[input] to player.symbol
#
#    checkForWinConditions()
#         isFinished = hasDiagonalWin() or hasVerticalWin() or hasHorizontalWin() or isTie()
#         if isFinished then set game state to FINISHED
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
