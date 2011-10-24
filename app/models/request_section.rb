class RequestSection < ActiveRecord::Base
  attr_accessible :section_id, :request_id, :comment
  
  belongs_to :request
  belongs_to :section
  has_many :section_roles, :dependent => :destroy
  has_many :section_items, :dependent => :destroy
  
  
 def update_items_values items   
   required_items = []
   for item_id in items.keys do
     section_item = SectionItem.where(:id =>item_id).first
     required_items << section_item unless section_item.nil?
   end
   i = 0
   for item in required_items do 
     item.update_attributes(:value => items.values[i].to_i)
     i+= 1
   end
  end

  def update_average
    sum = 0.0
    for role in self.section_roles.not_pending
      sum += role.average
    end
    self.average = sum / self.section_roles.not_pending.count
    self.save
    self.request.update_average
  end
  
  def finished
    self.section_roles.pending.empty?
  end
  
end
