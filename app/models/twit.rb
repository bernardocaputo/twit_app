class Twit < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  enum status: [:public, :private]
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 15 }
  validates :content, presence: true, length: { maximum: 140 }
end
