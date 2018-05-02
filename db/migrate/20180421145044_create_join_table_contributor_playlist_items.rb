class CreateJoinTableContributorPlaylistItems < ActiveRecord::Migration[5.2]
  def change
    create_join_table :contributors, :playlist_items do |t|
      t.index [:contributor_id, :playlist_item_id], :name => "c_p_i_id", :unique => true
      t.index [:playlist_item_id, :contributor_id], :name => "p_i_c_id", :unique => true
    end
  end
end
