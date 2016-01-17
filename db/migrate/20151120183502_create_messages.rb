class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title, null: false, index: true
      t.string :subtitle
      t.belongs_to :channel, index: true, foreign_key: true
      t.timestamps null: false
    end

    add_constraints if using_postgresql?
  end

  private

  def add_constraints
    execute('ALTER TABLE messages ADD CONSTRAINT title_length CHECK (char_length(title) <= 64);')
    execute('ALTER TABLE messages ADD CONSTRAINT subtitle_length CHECK (char_length(subtitle) <= 128);')
  end

  def using_postgresql?
    ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
  end
end
