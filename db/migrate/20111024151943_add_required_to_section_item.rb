class AddRequiredToSectionItem < ActiveRecord::Migration
  def self.up
    add_column :section_items, :required, :boolean, :default => false
  end

  def self.down
    remove_column :section_items, :required
  end
end
