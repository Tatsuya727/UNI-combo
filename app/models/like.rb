class Like < ApplicationRecord
  belongs_to :user
  belongs_to :combo
  validates :user_id, uniqueness: { scope: :combo_id }
end
