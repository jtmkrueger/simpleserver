class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :sent_at
      t.integer :down
      t.boolean :fixed
      t.timestamps
    end
  end

  def self.down
    drop_table :table_name
  end
end