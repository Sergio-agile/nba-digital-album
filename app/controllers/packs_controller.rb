class PacksController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @random_cards = @album.cards.sample(5)
    # @album_cards = AlbumCard.find(params[:id]) NEED TO SORT THIS OUT FOR PACKS - AND USE IN THE ALBUMS/SHOW AND CONTROLLER TOO
  end
end
