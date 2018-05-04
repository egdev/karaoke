class PlaylistsController < ApplicationController

	def index
    @playlist = Playlist.friendly.order(:created_at).last 
    redirect_to playlist_items_path :playlist_id => @playlist.friendly_id
	end
	
end
