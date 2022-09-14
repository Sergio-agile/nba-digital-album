class QuizzesController < ApplicationController
  def show
    @quiz = Quiz.find(params[:id])
    @album_id = params[:album_id]
    @quiz_first = Quiz.first.id
    @quiz_last = Quiz.last.id
  end
end
