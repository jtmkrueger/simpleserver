class AddBrokeSitesToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :broke_sites, :string
  end

  def self.down
    remove_column :reports, :broke_sites
  end
end
