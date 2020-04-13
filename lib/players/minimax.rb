require 'pry'

class Players
  class ComputerAI < Player

    def move(board)
      depth = board.available_spots.size
      move = minimax(board, depth, true)[0] + 1
      move.to_s
    end

    def final_scores(board)
      if board.winner == self.token
        +1
      elsif board.draw?
        0
      else
        -1
      end
    end

    def whose_move(board)
      if board.first_player = "computer"
        if board.turn_count.even?
          return "computer"
        elsif board.turn_count.odd?
          return "human"
        end
      elsif board.first_player = "human"
        if board.turn_count.even?
          return "human"
        elsif board.turn_count.odd?
          return "computer"
        end
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

    def best_move(board)
      bestScore = -Float::INFINITY
      move = ""
      board.available_spots.each do |move|
        board.cells[move] = self.token
        score = minimax(board, 0, false);
        board.cells[move] = ""
        if score > bestScore
          bestScore = score
          move = move
        end
        move + 1
      end
    end

    def minimax(board, depth, isMaximizing)
      #rewrite over in terms of the board
      if depth.zero? || board.over?
        return final_scores(board)
      end

      if isMaximizing == true
        bestScore = -Float::INFINITY
        board.available_spots.each do |move|
          board.cells[move] = self.token
          score = minimax(board, depth - 1, false);
          board.cells[move] = ""
          if score > bestScore
            bestScore = score 
          end
        end
      elsif isMaximizing == false
        bestScore = +Float::INFINITY
        board.available_spots.each do |move|
          board.cells[move] = get_opponent_piece(board, token)
          score = minimax(board, depth - 1, true);
          board.cells[move] = ""
          if score < bestScore
            best[1] = score
            best[0] = move
          end
        end
      end

      best
    end

  end
end
