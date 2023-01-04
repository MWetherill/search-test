class Album < ApplicationRecord
  validates :title, presence: true

  belongs_to :artist

  paginates_per 10
end
