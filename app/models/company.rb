class Company < ActiveRecord::Base
  attr_accessible :name, :sector_id
  belongs_to :sector
  has_many :request

end
