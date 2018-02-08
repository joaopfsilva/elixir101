defmodule Cards do
  @moduledoc """
    Provides the methods for creating and handling a deck of cards
  """

  @doc """
    Return a list of string representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["spades", "clubs", "hearts", "diamond"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  @doc """
    Return the deck shuffled
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Divid es a deck into a hand and a remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> { hand, _ } = Cards.deal(deck, 2)
      iex> hand
      ["Ace of spades", "Two of spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary deck
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, response } -> :erlang.binary_to_term response
      { :error, _reason } -> "File not found!"
    end
   end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
