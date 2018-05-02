class PlaylistItem < ApplicationRecord
  belongs_to :playlist
  belongs_to :song

  has_and_belongs_to_many :contributors

  acts_as_list scope: [:watched]

  validates :contributors, :length => { :minimum => 1 }
  
end
