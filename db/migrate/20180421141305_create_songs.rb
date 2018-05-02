class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title, :null => false
      t.integer :duration
      t.string :full_path
      t.string :checksum, :unique => true
      t.string :url

      t.timestamps
    end
  end
end
