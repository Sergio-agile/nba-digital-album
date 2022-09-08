class CreateQuizAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_answers do |t|
      t.string :text
      t.boolean :correct
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
