class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :admin

  validates :username, :uniqueness => true
  validates_presence_of :first_name, :last_name, :username, :password, :password_confirmation
  has_many :section_roles, :dependent => :destroy
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
end
