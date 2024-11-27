# frozen_string_literal: true
class TeamMemberHistory < ApplicationRecord
  #validations
  validates :member_id, :team_id, :team_role_id, presence: true
end
