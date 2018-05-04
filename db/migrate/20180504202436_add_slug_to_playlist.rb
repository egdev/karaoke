class AddSlugToPlaylist < ActiveRecord::Migration[5.2]
  def change
    change_table :playlists do |t|
      t.string :slug, after: :id
    end 
  end
end
