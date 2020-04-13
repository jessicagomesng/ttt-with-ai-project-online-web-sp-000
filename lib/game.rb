require 'pry'

class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    board.display
  end

  def WIN_COMBINATIONS
    WIN_COMBINATIONS
  end

  def current_player
    if board.turn_count.even?
      return @player_1
    else
      return @player_2
    end
  end

  def won?
    WIN_COMBINATIONS.find do |combination|
      position_1 = combination[0]
      position_2 = combination[1]
      position_3 = combination[2]
      board.cells[position_1] == board.cells[position_2] &&
      board.cells[position_2] == board.cells[position_3] &&
      board.taken?(position_1 + 1)
    end
  end

  def draw?
    !won? && board.full?
  end

  def over?
    won? || draw?
  end

  def winner
    board.cells[won?[0]] if won?
  end

  def turn
     puts "Player #{current_player.token}, please enter a number between 1-9:"
     input = current_player.move(board)
     if board.valid_move?(input) == true
       board.update(input, current_player)
       board.display
     else
       input = current_player.move(board)
     end
   end

   def play
     turn until over?
     if over?
       if won?
         puts "Congratulations #{winner}!"
       elsif draw?
         puts "Cat's Game!"
       end
     end
   end


   def self.start
     puts "What kind of game would you like to play? Please type '0 player', '1 player', or '2 player'."
     input = gets.strip

     if input == "0 player"
       player_1 = Players::Computer.new("X")
       player_2 = Players::Computer.new("O")
       game = new(player_1, player_2, board = Board.new)
       game.play
     end

     if input == "1 player"
       puts "Ok, you have chosen to play against the computer. Would you like to go first? Please type 'Y/N'."
       player_1 = gets.strip

       if player_1 == "Y"
         puts "You have chosen to go first. You will be 'Player X'."
         player_1 = Players::Human.new("X")
         player_2 = Players::ComputerAI.new("O")
         game = Game.new(player_1, player_2, board = Board.new("human"))
         game.play

       elsif player_1 == "N"
         puts "Alright, you'll go second! You will be 'Player O'."
         player_1 = Players::ComputerAI.new("X")
         player_2 = Players::Human.new("O")
         game = Game.new(player_1, player_2, board = Board.new("computer"))
         game.play
       end
     end

     if input == "2 player"
       puts "Ok, you have chosen a two-player game. Who would like to go first?"
         player_1_name = gets.strip
         player_1 = Players::Human.new("X")
         player_1.name = player_1_name
       puts "#{player_1.name} will be 'Player X'. Who would like to go second?"
         player_2_name = gets.strip
         player_2 = Players::Human.new("O")
         player_2.name = player_2_name
       puts "Ok, #{player_2.name} will go second and be 'Player O'."
       puts "Let's begin!"
       game = Game.new(player_1, player_2, board = Board.new)
       game.play
     end

     puts "Peety congratulates you! Would you like to play again? Please type 'Y/N'."
     answer = gets.strip
     if answer == "Y"
       puts "You're on a roll!"
       start
     elsif answer == "N"
       puts "Thanks for playing! Please come again!"
     end

   end

 end
