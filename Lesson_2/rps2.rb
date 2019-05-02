# rps2.rb

# matchup_hash = { 'rock' => ['scissors', 'lizard'],
#                  'paper' => ['rock', 'spock'],
#                  'scissors' => ['paper', 'lizard'],
#                  'lizard' => ['spock', 'paper'],
#                  'spock' => ['scissors', 'rock'] }

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (scissors? && other_move.rock?) ||
      (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    set_name
    @score = 0
    @move_history = []
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Choose rock, paper, or scissors."
      choice = gets.chomp
      break if ['rock', 'paper', 'scissors'].include? choice
      puts "Must choose rock, paper, or scissors."
    end
    self.move = Move.new(choice)
    move_history << move.value
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'C3PO', 'Chappie'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    move_history << move.value
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors."
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def set_match_goal
    puts "How many rounds do you want to play to? (0-10)"
    answer = ''
    loop do
      answer = gets.chomp.to_i
      break if (answer <= 10) && (answer > 0)
      puts "Must enter a number between 1 and 10."
    end
    @@goal = answer
  end

  def display_move_history
    puts "#{human.name}'s move history => #{human.move_history}"
    puts "#{computer.name}'s move history => #{computer.move_history}"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Must answer y or n."
    end
    answer != 'y'
  end

  def display_score
    puts "#{human.name} => #{human.score}"
    puts "#{computer.name} => #{computer.score}"
  end

  def winning_score
    (computer.score == @@goal) || (human.score == @@goal)
  end

  def display_match_winner
    if computer.score > human.score
      puts "#{computer.name} has won the match!"
    else
      puts "#{human.name} won the match."
    end
  end

  def play
    display_welcome_message
    set_match_goal
    loop do
      display_score
      human.choose
      computer.choose
      display_winner
      display_score
      break if winning_score || play_again?
    end
    display_move_history
    display_match_winner
    display_score
    display_goodbye_message
  end
end

RPSGame.new.play
