class AddCompanyIdToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :company_id, :integer
  end

  def self.down
    remove_column :requests, :company_id
  end
end
