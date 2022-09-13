class AlbumsController < ApplicationController
  def cards
  end

  def quizzes
  end

  def show
    @album = Album.find(params[:id])
    index = params[:index].to_i || 0
    batches = @album.cards.each_slice(6).to_a
    @cards = batches[index] || []

    # @team = @album.cards.first.team
    @team = @cards.first.team

    batches_count = batches.count

    if batches_count == index + 1
      @next_index = nil
    else
      @next_index = index + 1
    end

    @prev_index = (index - 1).negative? ? nil : index - 1
  end
end
