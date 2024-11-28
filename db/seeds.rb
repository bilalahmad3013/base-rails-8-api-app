# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create(email_address: "ba7254491@gmail.com", password_digest:"Jalnodea@123")
User.create(email_address: "bilal@gmail.com", password_digest:"Jalnodea@123")
User.create(email_address: "anzar@gmail.com", password_digest:"Jalnodea@123")

User.first.workspaces.create(name: "Ongraph", description: "This workspace is for ongraph")
User.first.workspaces.create(name: "Texo", description: "This workspace is for texo")

WorkspaceRole.create(name: "Admin", description: "This is for admin role")
WorkspaceRole.create(name: "Semi Admin", description: "This is for semi-admin role")

WorkspaceMember.create(workspace_id: 1, member_id: 1, workspace_role_id: 1)
WorkspaceMember.create(workspace_id: 1, member_id: 2, workspace_role_id: 1)

Team.create(name: "ROR Jaipur", description: "This is for ROR, Jaipur", created_by_id: 1, workspace_id: 1)
Team.create(name: "MERN Jaipur", description: "This is for MERN, Jaipur", created_by_id: 1, workspace_id: 1)

TeamRole.create(name: "Admin", description: "This for admin", workspace_id: 1)
TeamRole.create(name: "Semi Admin", description: "This for semi-admin", workspace_id: 1)

TeamMember.create(member_id: 1, team_id: 1, team_role_id: 1)
