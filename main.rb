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

class Choice
  def initialize
    puts 'Enter "C" to be a creator or "G" to be a guesser'
    choice = gets.chomp
    if choice.upcase  == "C"
      user = Player.new
      winning_colors = []
      4.times {|i| winning_colors << user.choice(i+1)}
      guesser = Computer.new
    elsif choice.upcase == "G"
      guesser = Player.new
      winning_colors = []
      4.times {winning_colors << COLORS.sample}
    end
    Game.new(guesser, winning_colors)
  end
end

class Game
  include DisplayBoard
  attr_reader :user, :winning_colors, :computer, :player, :hints, :check, :play, :guesser

  def initialize(guesser, winning_colors)
    @guesser = guesser
    @winning_colors = winning_colors
    display_board
    while @guesser.turns > 0
      @guesser.selection
      check(BOARD[@guesser.turns],@winning_colors)
    end
    puts "Game over! Loser is #{@guesser.class}. Winning colors are #{@winning_colors}"
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
    BOARD[@guesser.turns].append(@hints)
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
      puts "Game over! Winner is #{@guesser.class}!"
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

  def selection
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
  
  def selection
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

Choice.new