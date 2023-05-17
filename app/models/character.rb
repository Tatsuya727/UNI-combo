class Character < ApplicationRecord
    validates :character_name, presence: true
    has_many :combos
end
