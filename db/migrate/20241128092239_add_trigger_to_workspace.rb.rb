class AddTriggerToWorkspace < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION workspace_trigger_function()
      RETURNS TRIGGER AS $$
      DECLARE
        new_workspace_member_id INTEGER;
      BEGIN
        INSERT INTO workspace_members (workspace_id, member_id, workspace_role_id, created_at, updated_at)
        VALUES (
          NEW.id,
          NEW.created_by_id,
          (SELECT id FROM workspace_roles WHERE name = 'Admin' LIMIT 1),
          NOW(),
          NOW()
        )
        RETURNING id INTO new_workspace_member_id;

        INSERT INTO member_histories (member_id, workspace_id, workspace_role_id, team_id, team_role_id, created_at, updated_at)
        VALUES (
          NEW.created_by_id,
          NEW.id,
          (SELECT id FROM workspace_roles WHERE name = 'Admin' LIMIT 1),
          NULL,
          NULL,
          NOW(),
          NOW()
        );

        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER workspace_trigger
      AFTER INSERT ON workspaces
      FOR EACH ROW
      EXECUTE FUNCTION workspace_trigger_function();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS workspace_trigger ON workspaces;
      DROP FUNCTION IF EXISTS workspace_trigger_function;
    SQL
  end
end
