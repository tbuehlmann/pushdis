class CreateMessageCounterCacheTriggerForChannels < ActiveRecord::Migration
  def change
    if using_postgresql?
      sql = <<-SQL
        CREATE TRIGGER update_channel_messages_count
          AFTER INSERT OR UPDATE OR DELETE ON messages
          FOR EACH ROW EXECUTE PROCEDURE counter_cache('channels', 'messages_count', 'channel_id');
      SQL

      execute(sql)
    end
  end

  private

  def using_postgresql?
    ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
  end
end
