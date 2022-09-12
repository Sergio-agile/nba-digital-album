class Card < ApplicationRecord
  has_many :album_cards, dependent: :destroy
  has_many :albums, through: :album_cards
end
