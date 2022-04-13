COLORS = %w[red green blue orange yellow black white brown].freeze

BOARD = [%w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _],
         %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _], %w[_ _ _ _]]

# display the game board as 12 rows
module DisplayBoard
  def display_board
    BOARD.each do |row|
      p row
    end
  end
end

# allows for user to choose to be a creator or guesser and starts the game
class Choice
  attr_reader :guesser, :choice, :winning_colors

  def initialize
    puts 'Enter "C" to be a creator or "G" to be a guesser'
    @choice = gets.chomp
    selection
    Game.new(guesser, winning_colors)
  end

  def selection
    @winning_colors = []
    case @choice.upcase
    when 'C'
      user = Player.new
      4.times { |i| @winning_colors << user.choice(i + 1) }
      @guesser = Computer.new
    when 'G'
      @guesser = Player.new
      4.times { @winning_colors << COLORS.sample }
    end
  end
end

# plays the game of mastermind
class Game
  include DisplayBoard
  attr_reader :user, :winning_colors, :computer_copy, :player, :hints, :computer, :player_copy, :guesser

  def initialize(guesser, winning_colors)
    @guesser = guesser
    @winning_colors = winning_colors
    display_board
    while @guesser.turns.positive?
      @guesser.selection
      check(BOARD[@guesser.turns],@winning_colors)
    end
    puts "Game over! Loser is #{@guesser.class}. Winning colors are #{@winning_colors}"
  end

  def comp_selection
    comp_selection = []
    4.times { comp_selection << COLORS.sample }
    comp_selection
  end

  def check(player, computer)
    @player = player
    @computer = computer
    @hints = ""
    @computer_copy = @computer.dup
    @player_copy = @player.dup
    match
    exist
    BOARD[@guesser.turns].append(@hints)
    display_board
    puts @hints
    win
  end

  def match
    (0..3).each do |i|
      next unless @computer[i] == @player[i]

      @hints << 'g'
      @computer_copy[i] = 'match'
      @player_copy[i] = 'used'
    end
    @computer_copy
  end

  def exist
    (0..3).each do |i|
      next unless @computer_copy.include? @player_copy[i]

      @computer_copy[@computer_copy.index(@player_copy[i])] = 'exist'
      @hints << 'w'
    end
  end

  def win
    return unless @player[4] == 'gggg'

    puts "Game over! Winner is #{@guesser.class}!"
    exit
  end
end

# guesser class with 12 turns
class Guesser
  attr_accessor :turns

  def initialize
    @turns = 12
  end
end

# user with ability to choose and make selections
class Player < Guesser
  include DisplayBoard

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
    4.times { |i| player_selection << choice(i+1) }
    BOARD[@turns - 1] = player_selection
    @turns -= 1
  end
end

# a computer class which tries to guess the correct colors
class Computer < Guesser
  include DisplayBoard

  def selection
    if @turns == 12
      comp_selection = []
      4.times { comp_selection << COLORS[7] }
    elsif BOARD[@turns][4].length < 4
      comp_selection = BOARD[@turns].dup
      comp_selection.pop(5 - BOARD[@turns][4].length)
      p BOARD[@turns]
      (4 - BOARD[@turns][4].length).times { comp_selection << COLORS[@turns - 6] }
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