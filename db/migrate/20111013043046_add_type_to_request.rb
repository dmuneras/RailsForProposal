class AddTypeToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :type, :string
  end

  def self.down
    remove_column :requests, :type
  end
end
