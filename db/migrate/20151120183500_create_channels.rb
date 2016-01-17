class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string   :name, null: false, index: true
      t.datetime :last_message_at, index: true
      t.integer  :messages_count, null: false, default: 0
      t.timestamps null: false, index: true
    end

    add_constraints if using_postgresql?
  end

  private

  def add_constraints
    execute("ALTER TABLE channels ADD CONSTRAINT name_format CHECK (name ~ '^[a-z0-9_-]*$');")
    execute('ALTER TABLE channels ADD CONSTRAINT name_uniqueness UNIQUE (name);')
    execute('ALTER TABLE channels ADD CONSTRAINT name_length CHECK (char_length(name) <= 16);')
  end

  def using_postgresql?
    ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
  end
end
