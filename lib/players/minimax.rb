require 'pry'

class Players
  class ComputerAI < Player

    def final_scores(board)
      if board.winner == self.token
        +1
      elsif board.draw?
        0
      else
        -1
      end
    end

    def get_opponent_piece(board, token)
      #check the board at each occupied spot
      #return the first occupied spot where the token isn't yours
      select = board.occupied_spots.find { |occupied_spot| board.cells[occupied_spot] != self.token }.to_i
      board.cells[select]
    end

    def switch_players(board, token)
      token == self.token ? get_opponent_piece(board, token) : self.token
    end

  #  def best_move(board)
  #    depth = board.available_spots.size
  #    bestScore = -Float::INFINITY
  #    move = ""
  #    board.available_spots.each do |move|
  #      board.cells[move] = self.token
  #      score = minimax(board, depth, false);
  #      board.cells[move] = ""
  #      if score > bestScore
  #        bestScore = score
  #        move = move
  #      end
  #      binding.pry
  #      move
  #    end
  #  end

    def minimax(board, depth, isMaximizing)
      #rewrite over in terms of the board
      if depth.zero? || board.over?
        return final_scores(board)
      end

      if isMaximizing == true
        bestScore = -Float::INFINITY
        bestMove = 0
        board.available_spots.each do |move|
          board.cells[move] = self.token
          score = minimax(board, depth - 1, false)
          board.cells[move] = ""
          if score[0] > bestScore
            bestScore = score[0]
            binding.pry
            bestMove = move
          end
        end
      elsif isMaximizing == false
        bestScore = +Float::INFINITY
        board.available_spots.each do |move|
          board.cells[move] = get_opponent_piece(board, token)
          score = minimax(board, depth - 1, true)
          board.cells[move] = ""
          if score[0] < bestScore
            bestScore = score[0]
            bestMove = move
          end
        end
        binding.pry
        bestMove + 1
      end
    end

    def move(board)
      depth = board.available_spots.size
      minimax(board, depth, true).to_s
    end

  end
end
