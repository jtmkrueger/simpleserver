class AddBodyToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :body, :string
  end

  def self.down
  end
end
