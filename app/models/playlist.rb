class Playlist < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :items, class_name: "PlaylistItem"

  has_many :watched_items, -> { where(watched: true).order(position: :asc) }, class_name: "PlaylistItem"
  has_many :unwatched_items, -> { where(watched: false).order(position: :asc) }, class_name: "PlaylistItem"

  has_many :songs, through: :items 
  
  has_many :watched_songs, through: :watched_items, class_name: "Song", source: :song
  has_many :unwatched_songs, through: :unwatched_items, class_name: "Song", source: :song
end
