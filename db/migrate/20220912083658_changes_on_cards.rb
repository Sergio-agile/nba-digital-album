class ChangesOnCards < ActiveRecord::Migration[7.0]
  def change
    remove_column :cards, :counter
    remove_reference :cards, :album, index: true
    add_column :cards, :season, :string
    change_column :album_cards, :counter, :integer, default: 0
  end
end
