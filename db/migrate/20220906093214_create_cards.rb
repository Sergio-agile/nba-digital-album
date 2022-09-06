class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :team
      t.string :position
      t.date :birthdate
      t.string :draft
      t.float :height
      t.float :weight
      t.float :points
      t.float :rebounds
      t.float :assists
      t.integer :index
      t.integer :counter, default: 0
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
