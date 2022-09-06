class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :question
      t.string :true_answer
      t.string :false_answer_one
      t.string :false_answer_two

      t.timestamps
    end
  end
end
