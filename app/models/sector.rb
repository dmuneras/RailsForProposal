class Sector < ActiveRecord::Base
  attr_accessible :name
  has_many :companies

  def self.rqs_per_sector 
    sectors = []
    for sector in Sector.all do
      sectors << {:name => sector.name, :no_companies => sector.companies.count}
    end
    return sectors
  end
end
