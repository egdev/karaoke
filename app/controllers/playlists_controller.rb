class PlaylistsController < ApplicationController

	def index
    @playlist = Playlist.order(:created_at).last 
    redirect_to playlist_items_path :playlist_id => @playlist.id
	end
	
end
