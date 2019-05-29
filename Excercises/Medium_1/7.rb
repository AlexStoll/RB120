# Add a low and high value for the guessing range
# number_of_guesses = Math.log2(size_of_range).to_i + 1

class GuessingGame

  def play
    @size_of_range = @high.to_i - @low.to_i
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

  def initialize(low, high)
    @high, @low = high.to_i, low.to_i
    @size_of_range = @high - @low
    @correct_number = (@low..@high).to_a.sample
    @guesses_remaining = Math.log2(@size_of_range).to_i + 1
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
    print "Enter a number between #{@low} and #{@high}: "
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
        prompt_user
        next
      end

      break if (@low..@high).include?(response.to_i)
      prompt_user
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

game = GuessingGame.new(0, 100)
game.play