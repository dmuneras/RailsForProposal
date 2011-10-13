class RemoveTypeToRequest < ActiveRecord::Migration
  def self.up
    remove_column :requests, :type
  end

  def self.down
    add_column :requests, :type, :string
  end
end
