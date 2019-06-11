# medium_1.rb

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

bank = BankAccount.new(100)
p bank.positive_balance?