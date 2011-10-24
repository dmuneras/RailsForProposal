class SectionItem < ActiveRecord::Base

  attr_accessible :request_section_id, :name, :required, :value
  
  validates :name, :value, :presence => true
  
  belongs_to :request_section
  
end
