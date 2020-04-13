class Players
  class Computer < Player
#these must be defined as inputs rather than as indexes
#available spots are defined as idnexes

    def move(board)

      if !board.taken?("5")
        return "5"
      elsif board.turn_count == 1
        return "1"
      elsif board.turn_count == 2
        move = [1, 3, 7, 9].detect { |i| !board.taken?(i) }.to_s
      elsif board.turn_count == 3 && (board.position(1) == board.position(9) || board.position(3) == board.position(7))
        move = "2"
      else
        Game::WIN_COMBINATIONS.detect do |combination|

          if combination.select {|i| board.position(i + 1) == token}.size == 2 && combination.any?{ |i| board.position(i+1) == " "}
            move = combination.select {|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
          elsif combination.select {|i| board.position(i + 1) != " " && board.position(i + 1) != token}.size == 2 && combination.any? { |i| board.position(i+1) == " " }
            move = combination.select {|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
          end
        end

      move = [1, 3, 7, 9, 2, 4, 6, 8].detect {|i| !board.taken?(i)}.to_s if move == nil
      end
    move
    end

  end
end 
