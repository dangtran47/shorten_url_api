class MapUrl < ApplicationRecord
  self.primary_key = "shorten_url"
  validates :shorten_url, presence: true, length: { minimum: 6, maximum: 100 }, uniqueness: true
  validates :original_url, presence: true, length: { minimum: 1, maximum: 300 }
end
