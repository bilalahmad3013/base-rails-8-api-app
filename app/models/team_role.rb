class TeamRole < ApplicationRecord
  belongs_to :workspace
  has_many :team_members, foreign_key: :team_role_id
end
