# ttt_bonus_features.rb

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],  # rows
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],  # columns
                   [1, 5, 9], [3, 5, 7]]             # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def list_unmarked_keys
    list = ''
    unmarked_keys[0..-2].each { |item| list << "#{item}, " }
    list << "or #{unmarked_keys[-1]}."
    list = unmarked_keys[0] if unmarked_keys.size == 1
    list
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line| # 'line' is each winning combo
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def ai_defense
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_human_markers?(squares)
        return find_unmarked_square(line)
      end
    end
    nil
  end

  def ai_offense
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_computer_markers?(squares)
        return find_unmarked_square(line)
      end
    end
    nil
  end

  def find_unmarked_square(line)
    line.each do |num|
      if @squares[num].marker == " "
        return num
      end
    end
  end

  def two_human_markers?(squares)
    (squares.select(&:human_marked?).size == 2) &&
      (squares.select(&:unmarked?).size == 1)
  end

  def two_computer_markers?(squares)
    (squares.select(&:computer_marked?).size == 2) &&
      (squares.select(&:unmarked?).size == 1)
  end

  def square_5_open?
    squares[5].unmarked?
  end

  def ai_strategy
    return 5 if square_5_open?
    return ai_offense if ai_offense
    return ai_defense if ai_defense
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts ""
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker) ###
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  attr_accessor :marker

  def initialize(marker=TTTGame::INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != TTTGame::INITIAL_MARKER
  end

  def unmarked?
    marker == TTTGame::INITIAL_MARKER
  end

  def human_marked?
    marker == TTTGame::HUMAN_MARKER
  end

  def computer_marked?
    marker == TTTGame::COMPUTER_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class Computer < Player
  def ai_defense
    Board::WINNING_LINES.each do |line|
      squares = Board.squares.values_at(*line)
      if Board.two_human_markers?(squares)
        return Board.find_unmarked_square(line)
      end
    end
    nil
  end

  def ai_offense
    Board::WINNING_LINES.each do |line|
      squares = Board.squares.values_at(*line)
      if Board.two_computer_markers?(squares)
        return Board.find_unmarked_square(line)
      end
    end
    nil
  end

   def ai_strategy
    return 5 if board.square_5_open?
    return ai_offense if ai_offense
    return ai_defense if ai_defense
    nil
  end
end

class TTTGame
  INITIAL_MARKER = " "
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = COMPUTER_MARKER
  WINNING_SCORE = 3

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def greet
    clear
    display_welcome_message
  end

  def display_match_ending
    display_match_winner
    display_goodbye_message
  end

  def play
    greet
    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_and_display_board if human_turn?
      end
      display_result
      display_score
      break if winning_score?
      break unless play_again?
      start_next_round
    end
    display_match_ending
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe."
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing. Bye!"
  end

  def clear_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "You're an #{human.marker}. Computer is an #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def display_score
    puts "Current standings:"
    puts "You: #{human.score}"
    puts "Computer: #{computer.score}"
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_moves
    puts "Chose a square from the following: #{board.list_unmarked_keys}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Must choose a number between 1 and 9"
    end

    board[square] = human.marker
  end

  def computer_moves
    strategic_move = computer.ai_strategy
    if strategic_move # if it's not 'nil'
      board[strategic_move] = computer.marker
    else # no strategic move available, random choice
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result
    clear_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won."
      human.score += 1
    when computer.marker
      puts "Computer won."
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Want to keep playing? (y or n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Must be y or n."
    end

    answer == 'y'
  end

  def winning_score?
    (human.score == WINNING_SCORE) || (computer.score == WINNING_SCORE)
  end

  def display_match_winner
    if human.score > computer.score
      puts "You've won the match."
    elsif human.score <= computer.score
      puts "You've lost the match."
    end
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def start_next_round
    reset
    puts "Let's play again."
    puts ''
  end
end

game = TTTGame.new
game.play
