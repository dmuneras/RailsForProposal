# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

sections = %w[Jurídica Contractual Financiera Técnica]

sections.each do |section|
  Section.find_or_create_by_name(section)
end

puts "creating a admin..."
user = User.create(:username => "admin", :email => "admin@admin.com", :password => "admin", :password_confirmation => "admin", :admin => true)

if user.save
  puts "admin was created"
else
  puts "admin wasnt created"
end

rq = Request.create(:name => "RoR", :start_date => "2011-08-16", :decision_date => "2011-08-16", )

if rq.save
  puts "request was created"
else
  puts "request wasnt created"
end
