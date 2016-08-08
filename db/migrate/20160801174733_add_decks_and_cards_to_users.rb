class AddDecksAndCardsToUsers < ActiveRecord::Migration
  def change
    add_reference :decks, :user, index: true
    add_reference :cards, :deck, index: true
  end
end
