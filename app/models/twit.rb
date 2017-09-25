class Twit < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user, presence: true
  scope :newest_first, -> {
  order(created_at: :desc)
  }
end
