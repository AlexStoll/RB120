# Determine the lowest and highest ranking cards
# in an array of card objects

# Cards are 2 - 10, Jack, Queen, King, Ace
# Suit is irrelevant
# If two cards are same rank, just return either
# Also def to_s that returns "Jack of Diamonds" etc.

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')