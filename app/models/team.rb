class Team < ApplicationRecord
  belongs_to :league
  has_many :games
end
