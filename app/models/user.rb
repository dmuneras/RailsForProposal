class User < ActiveRecord::Base

  #ACCESS TO VARIABLES
  acts_as_authentic
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :admin

  #VALIDATIONS
  validates :username, :uniqueness => true
  validates_presence_of :first_name, :last_name, :username, :password, :password_confirmation

  #DATABASE RELATIONSHIPS
  has_many :section_roles, :dependent => :destroy
  has_many :request_sections, :through => :section_roles


  def full_name
    "#{first_name} #{last_name}"
  end

  def associate_requests
    result = []
    for section in self.request_sections 
      result << section.request
    end
    result = result.uniq
    return result
  end

  def status_requests
    pending = accepted = rejected = 0
    for rq in self.associate_requests do
      if rq.status == "pending"
        pending += 1
      elsif rq.status == "accepted"
        accepted += 1
      else
        rejected += 1
      end
    end
    result = Hash["pending"=> pending, "rejected" => rejected, "accepted" => accepted]
    return result
  end

  #USER STATISTICS 

  def self.statistics_per_user
    result = []
    for user in User.all do
      data = Hash.new
      data["username"] = user.username
      data["total_rfp"] = user.associate_requests.count
      data["total_rfp_per_status"] = user.status_requests
      result << data
    end
    return result
  end
end
