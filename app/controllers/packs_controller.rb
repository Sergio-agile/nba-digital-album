class PacksController < ApplicationController

  def show
    @album = Album.find(params[:id])

    @season = @album.season
    @season_short = @season.chars.last(2).join
    @prev_season = @season_short.to_i - 1

    @random_cards = @album.cards.sample(5)
    @quiz_first = Quiz.first.id
    @quiz_last = Quiz.last.id
  end
  
end
