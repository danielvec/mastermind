COLORS = ['red', 'green', 'blue', 'orange', 'yellow',
     'black', 'white', 'brown']

BOARD = [%w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], 
         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _]]

module DisplayBoard
  def display_board
    BOARD.each do |row|
      p row
    end
  end
end

class Game
  include DisplayBoard

  def initialize
    winning_colors = comp_selection
    display_board
  end

  def comp_selection
    comp_selection = []
    4.times {comp_selection << COLORS.sample}
    comp_selection
  end
end

Game.new