class Board

  attr_accessor :cells, :first_player

  def initialize(first_player)
    @first_player = first_player
    @cells = Array.new(9, " ")
  end

  def reset!
    cells.clear
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    index = input.to_i - 1
    cells[index]
  end

  def full?
    cells.all? { |cell| cell == "X" || cell == "O" }
  end

  def turn_count
    filled_cells = cells.select { |cell| cell == "X" || cell == "O" }
    filled_cells.length
  end

  def taken?(input)
    index = input.to_i - 1
    cells[index] == "X" || cells[index] == "O"
  end

  def valid_move?(input)
    index = input.to_i - 1
    !taken?(input) && index.between?(0, 8)
  end

  def update(input, player)
    index = input.to_i - 1
    cells[index] = player.token
  end

  def available_spots
    available_spots = []
    cells.each_with_index do |cell, index|
      if cell == " " || cell == ""
        available_spots << index
      end
    end
    available_spots
  end

  def occupied_spots
    occupied_spots = []
    cells.each_with_index do |cell, index|
      if cell == "X" || cell == "O"
        occupied_spots << index
      end
    end
    occupied_spots
  end

  def won?
    win_combinations = [[0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]]

    win_combinations.find do |combination|
      position_1 = combination[0]
      position_2 = combination[1]
      position_3 = combination[2]
      cells[position_1] == cells[position_2] &&
      [position_2] == cells[position_3] &&
      taken?(position_1 + 1)
    end
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    cells[won?[0]] if won?
  end

end
