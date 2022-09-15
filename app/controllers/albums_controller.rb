class AlbumsController < ApplicationController
  def cards
  end

  def quizzes
  end

  def index
    @albums = Album.where(user_id: current_user.id)
    # @album = Album.where(user_id: current_user.id)
    # @album = Album.find(params[:id])
  end

  def show
    @album = Album.find(params[:id])
    index = params[:index].to_i || 0
    batches = @album.cards.each_slice(6).to_a
    @cards = batches[index] || []


    @team = @cards.first.team

    batches_count = batches.count

    if batches_count == index + 1
      @next_index = nil
    else
      @next_index = index + 1
    end

    @prev_index = (index - 1).negative? ? nil : index - 1


    if index.odd?
      @color = "#1D428A" #this hash is the NBA $blue
    else
      @color = "#C8102E" #this hash is the NBA $blue
    end

    @quiz_first = Quiz.first.id
    @quiz_last = Quiz.last.id

    @season = @album.season
    @season_short = @season.chars.last(2).join
    @prev_season = @season_short.to_i - 1

  end
end
