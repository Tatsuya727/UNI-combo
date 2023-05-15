class Comment < ApplicationRecord
  belongs_to :combo
  belongs_to :user

  validates :body, presence: true, length: { maximum: 500 }
end
