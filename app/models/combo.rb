class Combo < ApplicationRecord
  belongs_to :user
  belongs_to :character, optional: true
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  has_one_attached :video_url
  mount_uploader :video_url, VideoUploader
  validates :title,        presence: true, length: { maximum: 100 }
  validates :comando,      presence: true, length: { maximum: 200 }
  validates :description,  presence: true, length: { maximum: 300 }
  validates :damage,       presence: true, numericality: { only_integer: true, 
                                                           greater_than_or_equal_to: 1,
                                                           less_than_or_equal_to: 10000 }
  validates :hit_count,    presence: true, numericality: { only_integer: true,
                                                           greater_than_or_equal_to: 1,
                                                           less_than_or_equal_to: 1000 }
  validates :video_url,    presence: true
  validates :character_id, presence: true
  validates :user_id,      presence: true
end
