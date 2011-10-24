class Request < ActiveRecord::Base
  
  attr_accessible :name, :start_date, :decision_date, :company, :comment, :filename, :response_time, :status, :average, :file_upload, :request_type_id
  attr_accessor :file_upload
  
  validates :name, :uniqueness => true
  validates_presence_of :name, :on => :create
  validates_presence_of :start_date , :on => :create
  validates_presence_of :decision_date, :on => :create

  has_many :comments, :as => :commentable
  has_many :request_sections, :dependent => :destroy
  has_many :sections, :through => :request_sections
  has_many :section_roles, :through => :request_sections
  has_many :section_items, :through => :request_sections
  
  belongs_to :request_type

  before_save :save_file
 
  def rated
    self.status != 'pending'
  end
  
  def section(id)
    self.request_sections.find_by_section_id(id)
  end
  
  def users    
    User.where(:id => self.section_roles.inject([]){ |a, s| a << s.user_id } )
  end
  
  def save_file
    return unless self.file_upload
    self.filename = self.file_upload.original_filename
    directory = "#{Rails.root}/public/upload/rfp/"
    path = File.join(directory,self.filename)
    File.open(path, "wb") { |f| f.write(self.file_upload.read) }
  end
  
  def update_average
    sum = 0.0
    for section in self.request_sections
      sum += section.average if section.average > 0.0 
    end    
    self.average = sum / self.request_sections.count
    save
  end
  
  def finished
    self.request_sections.inject(true){ |res, sec| res &&= sec.finished }
  end

  def satisfy_required_items
    if  required = self.section_items.where(:required => true, :value => 1).blank?
      return true
    else
      return false
    end
  
  end
  
  #TYPE AVERAGE METHODS 

  def self.average_gen array
    if array.blank?
      return 0
    end
    sum = 0.0
    for thing in array do
      sum += thing.average 
    end
    total_avg = sum / array.count
    return total_avg
  end

  def self.statistics_per_type_status(type, status)
    rqs = Request.where(:request_type_id => type.id, :status => status)
    avg_total = average_gen rqs
    result = Hash.new
    result["total"] = rqs.count
    result["avg_total"] = avg_total
    return result
  end
  
  def self.average_type type
    rqs = Request.where("request_type_id = :request_type_id AND decision_date > :today",
                        {:request_type_id => type.id, :today => Date.today}
    )
    return average_gen rqs
  end

  def end_first_evaluation 
    role = self.section_roles.first
    time = 0
    time = (( role.created_at -  self.created_at)/ 1.day).to_i unless role.nil? 
    return time
  end

  def self.first_evaluation_per_type type
    rqs = Request.where(:request_type_id => type.id)
    if rqs.blank?
      return 0.0
    end
    sum = 0.0
    for request in rqs do
      sum += request.end_first_evaluation
    end
    return total_avg = sum / rqs.count
  end

  
  def self.statistics_per_type
    result = []
    for type in RequestType.all do
      type_stat = Hash.new
      type_stat["name"] =  type.name  
      type_stat["avg"]  = self.average_type(type)
      type_stat["first_evaluation_time"] = self.first_evaluation_per_type(type) 
      type_stat["accepted_stat"] = self.statistics_per_type_status(type, "accepted") 
      type_stat["rejected_stat"] = self.statistics_per_type_status(type, "rejected") 
      result << type_stat
    end
    return result
  end

  def self.rfps_per_type
    result =[]
    for type in RequestType.all do
      data = Hash.new
      data["total"] = Request.where(:request_type_id => type.id).count  
      data["name"] = "#{type.name} ( #{data["total"]} )"
      result << data
    end
    return result
  end

end
