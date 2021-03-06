class Tournament < ApplicationRecord
  has_many :team_tournaments, dependent: :nullify
  has_many :teams, through: :team_tournaments
  has_many :soccer_matches, dependent: :destroy
end
