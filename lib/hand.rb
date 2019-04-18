require "byebug"
class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    aces = 0
    value = 0
    cards.each do |card|
      if card.value == :ace 
        aces += 1
      else
        value += card.blackjack_value
      end
    end
    ace_vals = Hand.ace_vals(aces,value)
    ace_vals > 21 ? 22 : ace_vals
      
  end

  def self.ace_vals(aces,val)
    return 0 if val > 21
    return val if aces == 0
    aces -= 1
    return [self.ace_vals(aces,val+1), self.ace_vals(aces,val+11)].max
  end

  def busted?
    return true if self.points > 21
    false
  end

  def hit(deck)
    # debugger
    raise "already busted" if self.busted?
    self.cards += deck.take(1)
  end

  def beats?(other_hand)
    return false if self.busted?
    return true if self.points > other_hand.points
    false
  end

  def return_cards(deck)
    deck.return(cards)
    self.cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
