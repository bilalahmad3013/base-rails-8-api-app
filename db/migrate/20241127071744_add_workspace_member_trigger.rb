class AddWorkspaceMemberTrigger < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      CREATE OR REPLACE FUNCTION add_workspace_trigger_member()
      RETURNS TRIGGER AS $$
      BEGIN
        INSERT INTO workspace_member_histories (
          member_id,
          workspace_id,
          workspace_role_id,
          created_at,
          updated_at
        )
        VALUES (
          NEW.member_id,
          NEW.workspace_id,
          NEW.workspace_role_id,
          NEW.created_at,
          NEW.updated_at
        );
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER add_workspace_trigger_member
      AFTER INSERT OR UPDATE ON workspace_members
      FOR EACH ROW
      EXECUTE FUNCTION add_workspace_trigger_member();
    SQL
  end

  def down
    execute <<~SQL
      DROP TRIGGER IF EXISTS add_workspace_trigger_member ON workspace_members;
      DROP FUNCTION IF EXISTS add_workspace_trigger_member();
    SQL
  end
end
