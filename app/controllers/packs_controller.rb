class PacksController < ApplicationController
  def show
    @alb = Album.find(params[:id])
    @all_cards = @alb.cards.all
    # @album_cards = AlbumCard.find(params[:id]) NEED TO SORT THIS OUT FOR PACKS - AND USE IN THE ALBUMS/SHOW AND CONTROLLER TOO
  end
end
