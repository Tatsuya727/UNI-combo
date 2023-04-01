class Character < ApplicationRecord
    validates :character_name, presence: true
end
