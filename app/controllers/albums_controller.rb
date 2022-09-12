class AlbumsController < ApplicationController
  def cards
  end

  def quizzes
  end

  def show
    @album = Album.find(params[:id])

    if params[:x].present?
      @x = params[:x].to_i
    else
      @x = 1

    end
    y = @x + 5

    @cards = @album.cards.where(id: @x..y)
    @year =  @album.cards.find(@x)

    if @x == 1
      @previous = @x
    elsif y == 180
      @next = @x
    else
      @next = @x + 6
      @previous = @x - 6
    end

    # @next isn't working now for some reason
  end
end
