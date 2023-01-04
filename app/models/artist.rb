class Artist < ApplicationRecord
  validates :title, presence: true

  has_many :albums

  paginates_per 10

  def self.artist_names
    Artist.pluck(:title)
  end
end
