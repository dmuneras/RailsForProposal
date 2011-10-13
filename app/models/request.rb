class Request < ActiveRecord::Base
  attr_accessible :name, :start_date, :decision_date, :company, :comment, :filename, :response_time, :status, :average, :file_upload, :request_type_id
  
  attr_accessor :file_upload

  validates :name, :uniqueness => true
  
  has_many :request_sections, :dependent => :destroy
  has_many :sections, :through => :request_sections
  has_many :section_roles, :through => :request_sections
  
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
  
  def self.average_type type
    rqs = Request.where(:request_type_id => type.id)
    sum = 0.0
    for request in rqs do
      sum += request.average
    end
    total_avg = sum / rqs.count
  end

  def self.average_per_type
    result = []
    for type in RequestType.all do
      type_avg = Hash.new
      type_avg["name"] = type.name
      type_avg["avg"] = self.average_type type
      result << type_avg
    end
    return result
  end
end
