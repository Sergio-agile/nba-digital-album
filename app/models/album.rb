class Album < ApplicationRecord
  belongs_to :user
  has_many :album_cards, dependent: :destroy
  has_many :cards, through: :album_cards
end
