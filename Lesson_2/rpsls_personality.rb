# rpsls_personality.rb

# rpsls.rb

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
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
      puts "Choose rock, paper, scissors, lizard, or spock."
      choice = gets.chomp
      break if Move::VALUES.include?(choice) ###
      puts "Must choose rock, paper, or scissors, lizard or spock."
    end
    self.move = Move.new(choice)
    move_history << move.value
  end
end


class R2D2 < Player
  def choose
    self.move = Move.new('rock')
    move_history << move.value
  end
end

class Chappie < Player
  CHAPPIE_BIAS = [(['rock'] * 2), 
                  (['paper'] * 3), 
                  'scissors', 
                  (['lizard'] * 2),
                  (['spock'] * 2)].flatten
  def choose
    self.move = Move.new(CHAPPIE_BIAS.sample)
    move_history << move.value
  end
end

class C3PO < Player
  def choose
    self.move = Move.new(['rock', 'paper', 'scissors'].sample)
    move_history << move.value
  end
end

class WATSON < Player
  def choose
    self.move = Move.new(Move::VALUES.sample)
    move_history << move.value
  end
end

class RPSGame
  attr_accessor :human, :computer

  COMBOS = { 'rock' => ['scissors', 'lizard'],
             'paper' => ['rock', 'spock'],
             'scissors' => ['paper', 'lizard'],
             'lizard' => ['spock', 'paper'],
             'spock' => ['scissors', 'rock'] }

  def initialize
    @human = Human.new
    @computer = choose_computer
  end

  def choose_computer
    answer = ''
    puts "Would you like to play Watson, C3PO, Chappie, or R2D2?"
    loop do
      answer = gets.chomp
      break if ['Watson', 'C3PO', 'Chappie', 'R2D2'].include?(answer)
      puts "Must pick a computer"
    end
    case answer
    when 'Watson' then return WATSON.new
    when 'Chappie' then return Chappie.new
    when 'C3PO' then return C3PO.new
    when 'R2D2' then return R2D2.new  
    end
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

  def human_win?
    COMBOS.fetch(human.move.value).include?(computer.move.value)
  end

  def computer_win?
    COMBOS.fetch(computer.move.value).include?(human.move.value)
  end

  def determine_winner
    if human_win?
      puts 'You won!'
      human.score += 1
    elsif computer_win?
      puts 'Computer won!'
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

  def winning_score?
    (computer.score == @@goal) || (human.score == @@goal)
  end

  def display_match_winner
    if computer.score > human.score
      puts "#{computer.name} has won the match!"
    else
      puts "#{human.name} won the match!"
    end
  end

  def play
    display_welcome_message
    set_match_goal
    loop do
      display_score
      human.choose
      computer.choose
      display_moves
      determine_winner
      display_score
      break if winning_score? || play_again?
    end
    display_match_winner
    display_move_history
    display_goodbye_message
  end
end

RPSGame.new.play
