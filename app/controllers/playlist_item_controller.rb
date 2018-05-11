class PlaylistItemController < ApplicationController
  before_action :get_playlist
  before_action :get_items, only: [ :index, :new, :create ]
  
  def index
    @title = @playlist.name
    
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
  
  def show
    item = @playlist.items.includes(:song).find(params[:id])
    if item.song.url.to_s.starts_with?("http")
      redirect_to item.song.url.to_s
    else
      send_file(item.song.full_path)
    end
  end
  
  def new
    @contributor = Contributor.new
    @title = @playlist.name
    @item = @playlist.items.new  
  end
  
  def create
    @contributor = Contributor.new
    @item = @playlist.items.new(playlist_item_params)
    @watched_song = false
    @contributors_added = false
    
    if @playlist.watched_songs.exists?(@item.song_id)
      @watched_song = true      
    elsif @playlist.unwatched_songs.exists?(@item.song_id)
      @current_item = @playlist.items.find_by_song_id(@item.song_id)
      unless @current_item.nil?
        unless params[:playlist_item][:contributor_ids].nil?
          params[:playlist_item][:contributor_ids].each do |contributor_id|
            contributor = Contributor.find_by_id(contributor_id)
            @current_item.contributors << contributor unless contributor.nil? || @current_item.contributors.exists?(contributor_id)
          end
        end
      end
      #redirect_to new_playlist_item_path(@playlist.id), notice: 'La chanson est déjà dans la playlist le chanteur a été ajouté'
      @contributors_added = true
    elsif @item.valid?
      @item.save
    end
      
    respond_to do |format|
        format.html {
          if watched_song || !@item.valid?
             render :new
          else
            redirect_to new_playlist_item_path(@playlist.id), notice: @contributors_added ? 'La chanson est déjà dans la playlist le ou les participants ont été ajoutés': 'Chanson ajoutée à la playlist'
          end
        }
        format.js {
        }
    end

  end
  
  def sort
    PlaylistItem.transaction do
      unless params[:item].nil?
        params[:item].each_with_index do |item_id, index|
          @playlist.items.find(item_id).update_attribute("position", index + 1)
        end          
      end
     end
    respond_to do |format|
      format.html { render body: nil }
      format.js {}
    end
  end

  def watched
    @item = @playlist.unwatched_items.find_by_id(params[:item_id])

    unless @item.nil?
      @item.watched = true
      @item.save
    end
    
    @items = @playlist.unwatched_items.reload
    
    respond_to do |format|
      format.js {     
      }
    end
  end

  def destroy
    @item = @playlist.unwatched_items.find_by_id(params[:id])
    unless @item.nil?
      @item.destroy
    end

    @items = @playlist.unwatched_items.reload

    respond_to do |format|
      format.js {}
    end
  end

  private
  
  def get_playlist
    @playlist = Playlist.friendly.find(params[:playlist_id])
  end

  def playlist_item_params
    params.require(:playlist_item).permit(:song_id, contributor_ids: [])
  end

  def get_items
    @items = @playlist.items.includes(:song, :contributors).order(:position).where(:watched => false)
  end

end
