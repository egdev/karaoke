class CreatePlaylistItems < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_items do |t|
      t.references :playlist, :null => false
      t.references :song, :null => false
      t.integer :position, :null => false
      t.boolean :watched, :default => false, :null => false
      
      t.timestamps
      t.index [ :playlist_id, :song_id], :unique => true
    end
  end
end
