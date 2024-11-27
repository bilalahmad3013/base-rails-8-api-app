class AddTeamMemberTrigger < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      -- Create the trigger function
      CREATE OR REPLACE FUNCTION team_member_trigger_function()
      RETURNS TRIGGER AS $$
      BEGIN
       INSERT INTO team_member_histories (
         member_id,
         team_role_id,
         team_id,
         created_at,
         updated_at
       )
       VALUES(
         NEW.member_id,
         NEW.team_role_id,
         NEW.team_id,
         NEW.created_at,
         NEW.updated_at
       );
       RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER team_member_history_trigger
      AFTER INSERT OR UPDATE ON team_members
      FOR EACH ROW
      EXECUTE FUNCTION team_member_trigger_function();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS team_member_history_trigger ON team_members;
      DROP FUNCTION IF EXISTS team_member_history_trigger_function();
    SQL
  end
end
