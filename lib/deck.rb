require_relative 'card'
require "byebug"
# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    ret_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        ret_cards << Card.new(suit,value)
      end
    end
    ret_cards
  end

  def initialize(cards = Deck.all_cards)
    @deck = cards
  end

  # Returns the number of cards in the deck.
  def count
    deck.length
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if n > count
    deck.shift(n)
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    # debugger
    deck.push(*cards)

  end
  protected
  attr_accessor :deck
end
