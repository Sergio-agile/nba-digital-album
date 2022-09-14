class PacksController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @random_cards = @album.cards.sample(5)
    @quiz_first = Quiz.first.id
    @quiz_last = Quiz.last.id

    flip = rand(1..2)
    if flip.even?
      @color = "#1D428A" #this hash is the NBA $blue
    else
      @color = "#C8102E" #this hash is the NBA $blue
    end
  end
end
