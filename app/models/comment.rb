class Comment < ApplicationRecord
  belongs_to :combo
  belongs_to :user
end
