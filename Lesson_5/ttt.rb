# figure out find_at_risk square method


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
      squares = @squares.values_at(*line) # returns value for each sqaure in that line
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  # def at_risk_square?
  #   WINNING_LINES.each do |line| # 'line' is each winning combo
  #     squares = @squares.values_at(*line) # returns value for each sqaure in that line
  #     if two_human_markers?(squares)
  #       return squares.first.marker
  #     end
  #   end
  #   nil
  # end

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
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
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

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  WINNING_SCORE = 3

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
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
      reset
      display_play_again_message
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

  def pick_at_risk_square

  end

  def computer_moves
    if board.at_risk_square?
      pick_at_risk_square
    elsif false #square 5 open?
      #pick square 5
    else
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
    human.score > computer.score ? (puts "You've won the match.") : (puts "You've lost the match.")
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again."
    puts ''
  end
end

# and then play the game

game = TTTGame.new
game.play
