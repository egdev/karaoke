class CreateJoinTableSingerSong < ActiveRecord::Migration[5.2]
  def change
    create_join_table :singers, :songs do |t|
      t.index [:singer_id, :song_id], :unique => true
      t.index [:song_id, :singer_id], :unique => true
    end
  end
end
