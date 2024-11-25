# frozen_string_literal: true
class TeamMember < ApplicationRecord
  # Associations
  belongs_to :member, class_name: "User", foreign_key: :member_id
  belongs_to :team
  belongs_to :team_role, class_name: "TeamRole", foreign_key: :team_role_id
end
