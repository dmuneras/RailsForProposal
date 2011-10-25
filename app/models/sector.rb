class Sector < ActiveRecord::Base
  attr_accessible :name
  has_many :companies

  def self.rqs_per_sector 
    sectors = []
    for sector in Sector.all do
      accepted = accepted_rq sector.companies
      rejected = rejected_rq sector.companies
      sectors << {:name => sector.name, :no_companies => sector.companies.count,
                  :rejected_rfps => rejected, :accepted_rfps => accepted}
    end
    return sectors
  end

  def self.accepted_rq array
    total = 0
    for company in array do
     total += company.requests.where(:status => "accepted").count
    end
    return total
  end

  def self.rejected_rq array
    total = 0
    for company in array do
      total += company.requests.where(:status => "rejected").count
    end
    return total
  end
end
