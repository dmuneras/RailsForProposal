class SectionRole < ActiveRecord::Base
  
  STATUS = %w[pending accepted rejected]

  belongs_to :user
  belongs_to :request_section

  scope :pending, where(:status => "pending")
  scope :accepted, where(:status => "accepted")
  scope :rejected, where(:status => "rejected")
  scope :not_pending, where("status != 'pending'")
  
  def rate(rates)
    items = self.request_section.section_items
    suma = 0
    for item in items do
      suma += item.value
    end
    self.average = suma / items.count
    self.status = 'rated'
    self.save
    self.request_section.update_average
  end

  def update_items_values(items)
    self.request_section.update_items_values(items)
  end
  
end
