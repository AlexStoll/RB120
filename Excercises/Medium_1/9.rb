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

class Deck
  attr_accessor :cards

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS  = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end

    @cards.shuffle!
  end
  
  def draw
    reshuffle if deck_out?
    @cards.pop
  end

  def reshuffle
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def deck_out?
    @cards.size == 0
  end
end

deck = Deck.new
drawn = []
52.times {drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
