class AddHostIdToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :host_id, :integer
  end

  def self.down
    remove_column :sites, :host_id
  end
end
