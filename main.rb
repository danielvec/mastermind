COLORS = ['red', 'green', 'blue', 'orange', 'yellow',
     'black', 'white', 'brown']
     
class Game
  def initialize
    winning_colors = comp_selection
  end

  def comp_selection
    comp_selection = []
    4.times {comp_selection << COLORS.sample}
    comp_selection
  end
end

Game.new