class AddRequestTypeIdToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :request_type_id, :integer
  end

  def self.down
    remove_column :requests, :request_type_id
  end
end
