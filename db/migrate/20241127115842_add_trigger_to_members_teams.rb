class AddTriggerToMembersTeams < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      -- Create the trigger function
      CREATE OR REPLACE FUNCTION team_member_trigger_function()
      RETURNS TRIGGER AS $$
      BEGIN
        INSERT INTO member_histories (
          team_role_id,
          member_id,
          team_id,
          workspace_id,
          workspace_role_id,
          created_at,
          updated_at
        )
        SELECT
          NEW.team_role_id,
          NEW.member_id,
          NEW.team_id,
          wm.workspace_id,
          wm.workspace_role_id,
          NEW.created_at,
          NEW.updated_at
        FROM workspace_members wm
        JOIN teams t ON wm.workspace_id = t.workspace_id
        WHERE
          t.id = NEW.team_id -- Match team to workspace
          AND wm.member_id = NEW.member_id
        LIMIT 1;

        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER team_member_trigger
      AFTER INSERT OR UPDATE ON team_members
      FOR EACH ROW
      EXECUTE FUNCTION team_member_trigger_function();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS team_member_trigger ON workspace_members;
      DROP FUNCTION IF EXISTS team_member_trigger_function;
    SQL
  end
end
