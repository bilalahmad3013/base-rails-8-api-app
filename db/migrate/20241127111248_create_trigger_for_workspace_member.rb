class CreateTriggerForWorkspaceMember < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      -- Create the trigger function
      CREATE OR REPLACE FUNCTION member_trigger_function()
      RETURNS TRIGGER AS $$
      BEGIN
       INSERT INTO member_histories (
         member_id,
         workspace_id,
         workspace_role_id,
         created_at,
         updated_at
       )
       VALUES(
         NEW.member_id,
         NEW.workspace_id,
         NEW.workspace_role_id,
         NEW.created_at,
         NEW.updated_at
       );
       RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER member_history_trigger
      AFTER INSERT OR UPDATE ON workspace_members
      FOR EACH ROW
      EXECUTE FUNCTION member_trigger_function();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS member_history_trigger ON workspace_members;
      DROP FUNCTION IF EXISTS member_trigger_function;
    SQL
  end
end
