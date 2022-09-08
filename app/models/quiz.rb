class Quiz < ApplicationRecord
  has_many :quiz_answers, dependent: :destroy
end
