class Album < ApplicationRecord
  belongs_to :user

  has_many :album_cards, dependent: :destroy
  has_many :cards, through: :album_cards

  after_create :add_cards

  def add_cards
    # grab all the cards where the season is same as season of this album
    cards_to_add = Card.where(season: season)
    cards_bulk_insert = cards_to_add.map do |card_to_add|
      {
        card_id: card_to_add.id,
        album_id: self.id
      }
    end
    AlbumCard.insert_all(cards_bulk_insert)
  end
end
