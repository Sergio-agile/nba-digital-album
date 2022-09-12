class CreateAlbumCards < ActiveRecord::Migration[7.0]
  def change
    create_table :album_cards do |t|
      t.integer :counter
      t.references :album, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end