class Card
  attr_accessor :suit, :name, :value

  def initialize(suit, name, value)
    @suit, @name, @value = suit, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITS = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITS.each do |suit|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suit, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def value
    # Want to add up the values of the cards here, keeping in mind that aces have two values
    @cards.each do |card|
      # TODO
    end
  end

  def busted?
    # TODO
  end

  def blackjack?
    # TODO
  end
end


require 'test/unit'

class HandTest < Test::Unit::TestCase
  def setup
    @hand = Hand.new
  end

  def test_add_card_adds_cards
    card = Card.new(:hearts, :ten, 10)
    @hand.add_card(card)
    assert(@hand.cards.include?(card))
  end

  def test_busted_false_when_score_less_than_21
    @hand.add_card(Card.new(:hearts, :ten, 10))
    @hand.add_card(Card.new(:hearts, :ten, 10))
    refute(@hand.busted?)
  end

  def test_busted_false_when_score_equal_21
    @hand.add_card(Card.new(:hearts, :ten, 10))
    @hand.add_card(Card.new(:hearts, :nine, 9))
    @hand.add_card(Card.new(:hearts, :two, 2))
    refute(@hand.busted?)
  end

  def test_busted_false_when_score_greater_than_21
    @hand.add_card(Card.new(:hearts, :ten, 10))
    @hand.add_card(Card.new(:hearts, :nine, 9))
    @hand.add_card(Card.new(:hearts, :three, 3))
    assert(@hand.busted?)
  end

  def test_value_when_simple
    @hand.add_card(Card.new(:hearts, :ten, 10))
    @hand.add_card(Card.new(:hearts, :nine, 5))
    @hand.add_card(Card.new(:hearts, :nine, 3))
    assert_equal @hand.value, 18
  end

  def test_value_when_over_21_with_ace
    @hand.add_card(Card.new(:hearts, :ten, 10))
    @hand.add_card(Card.new(:clubs, :five, 5))
    @hand.add_card(Card.new(:clubs, :ace, [11, 1]))
    assert_equal @hand.value, 16
  end

  def test_value_when_under_21_with_ace
    @hand.add_card(Card.new(:hearts, :nine, 9))
    @hand.add_card(Card.new(:clubs, :ace, [11, 1]))
    assert_equal @hand.value, 20
  end

  def test_is_blackjack_when_ace_and_10_point_card
    # TODO
  end

  def test_is_not_blackjack_when_ace_and_any_other_card
    # TODO
  end

end

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suit_is_correct
    assert_equal @card.suit, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    assert(!@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end

#Here's how I would approach the Game class...scaffolding for now
  #class Game
 # attr_accessor :player, :deck

  #def initiailze()
    #@player_hand = Hand.new
    #@deck = Deck.new
  #end

  #def start
    #while !@player_hand.busted?
      #hit
     # puts "Your hand is:"
      #@player_hand
      #puts "Your current score is: #{@player_hand.value}"
    #end
    #puts "Game over! You busted!"
  #end

  #def hit
  #  @player_hand.add_card(@deck.deal_card)
  #end
#end
end