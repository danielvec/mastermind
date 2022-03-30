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

class Player
  attr_accessor :choice
  def initialize
    p player_selection
  end

  def choice(number)
    puts "choose a color for space #{number} (red, green, blue, 
    orange, yellow, black, white, brown)"
    choice = gets.chomp
    return choice if COLORS.include? choice

    puts 'not a valid color'
    choice(number)
  end

  def player_selection
    player_selection = []
    4.times {|i| player_selection << choice(i+1)}
    player_selection
  end
end
Player.new