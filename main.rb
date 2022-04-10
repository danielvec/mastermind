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
  attr_reader :user, :winning_colors, :computer, :player, :hints, :check, :play

  def initialize
    winning_colors = comp_selection
    display_board
    #@user = Player.new
    @comp = Computer.new
    #while @user.turns > 0
      #@user.player_selection
      #check(BOARD[@user.turns],winning_colors)
    #end
    while @comp.turns > 0
      @comp.comp_selection
      check(BOARD[@comp.turns],winning_colors)
    end
    puts "You lose. Winning colors are #{winning_colors}"
  end

  def comp_selection
    comp_selection = []
    4.times {comp_selection << COLORS.sample}
    comp_selection
  end

  def check(player, computer)
    @player = player
    @computer = computer
    @hints = ""
    @check = @computer.dup
    @play = @player.dup
    match
    exist
    #BOARD[@user.turns].append(@hints)
    BOARD[@comp.turns].append(@hints)
    display_board
    puts @hints
    win
  end

  def match
    for i in 0..3
      if @computer[i] == @player[i]
        @hints << "g"
        @check[i] = "match"
        @play[i] = "used"
      end
    end
  end

  def exist
    @check
    for i in 0..3
      if @check.include? @play[i]
        @check[@check.index(@play[i])] = "exist"
        @hints << "w"
      end
    end
  end

  def win
    if @player[4] == "gggg"
      puts "you win"
      exit
    end
  end
end

class Player
  include DisplayBoard

  attr_accessor :turns
  def initialize
    @turns = 12
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
    BOARD[@turns - 1] = player_selection
    @turns -= 1
    puts @turns
  end
end

class Computer
  include DisplayBoard

  attr_accessor :turns
  def initialize
    @turns = 12
  end
  
  def comp_selection
    if @turns == 12
      comp_selection = []
      4.times {comp_selection << COLORS[7]}
    elsif BOARD[@turns][4].length < 4
      comp_selection = BOARD[@turns].dup
      comp_selection.pop(5-BOARD[@turns][4].length)
      p BOARD[@turns]
      (4-BOARD[@turns][4].length).times {comp_selection << COLORS[@turns-6]}
    else
      last_move = BOARD[@turns].dup
      last_move.pop
      comp_selection = last_move.shuffle
    end
    p @turns
    BOARD[@turns - 1] = comp_selection
    @turns -= 1
  end
end  

Game.new