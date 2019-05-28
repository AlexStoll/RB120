class GuessingGame

  def play
    loop do
      show_remaining_guesses
      player_guesses
      break if player_win? || out_of_guesses?
      display_too_high_or_low
    end

    display_result
  end

  private

  def display_result
    if player_win?
      display_win
    else
      display_loose
    end
  end

  def out_of_guesses?
    @guesses_remaining == 0
  end

  def initialize
    @correct_number = (0..100).to_a.sample
    @guesses_remaining = 7
  end

  def display_win
    puts ""
    puts "That's the number!"
    puts ""
    puts "You've won!"
  end

  def display_loose
    puts ""
    puts "You're out of guesses, you've lost!"
    puts "The correct number was: #{@correct_number}"
    puts ""
  end

  def show_remaining_guesses
    puts "You have #{@guesses_remaining} guesses remaining."
  end

  def prompt_user
    print "Enter a number between 1 and 100: "
  end

  def show_too_high
    puts "You're guess is too high."
    puts ""
  end

  def show_too_low
    puts "You're guess is too low."
    puts ""
  end

  def player_guesses
    prompt_user
    response = nil
    loop do
      response = gets.chomp
      if response == ""
        puts "Must enter a number 0 - 100."
        next
      end

      break if (0..100).include?(response.to_i)
      puts "Must enter a number 0 - 100."
    end

    @guess = response.to_i
    @guesses_remaining -= 1
  end

  def player_win?
    @guess == @correct_number
  end

  def display_too_high_or_low
    if @guess > @correct_number
      show_too_high
    else
      show_too_low
    end
  end
end

game = GuessingGame.new
game.play