# -*- coding: utf-8 -*-
module RequestsHelper

  def general_info rfp 
    content_tag(:tr) do
      content_tag(:td, rfp.name) <<
      content_tag(:td, rfp.start_date) <<
      content_tag(:td, rfp.decision_date) <<
      unless rfp.company.nil?
        content_tag(:td, rfp.company.name)
      else
        content_tag(:td, t(:no_registered))
      end <<
      content_tag(:td, rfp.status) <<
      content_tag(:td, "%0.2f" % rfp.average) <<
      content_tag(:td) do
          content_tag( :a, (link_to t(:manage), rfp))
      end <<
      
      unless  rfp.filename.nil?
        content_tag(:td) do
          content_tag( :a, (link_to t(:show), "/upload/rfp/#{rfp.filename}", :target => "_blank")) 
        end
      end <<
      content_tag(:td) do
          content_tag( :a, (link_to t(:edit),  edit_request_path(rfp)))
      end << 
      content_tag(:td) do
          content_tag( :a, (link_to t(:delete), rfp, :confirm => '¿Está seguro?', :method => :delete))
      end
    end
  end  

  def request_type_info report
    content_tag :tr do
      content_tag(:td, report["name"]) <<
      content_tag(:td, "%0.2f" % report["avg"]) <<
      content_tag(:td, report["accepted_stat"]["total"]) <<
      content_tag(:td, report["accepted_stat"]["avg_total"]) <<
      content_tag(:td, report["rejected_stat"]["total"]) <<
      content_tag(:td, report["rejected_stat"]["avg_total"]) <<
      content_tag(:td, "#{report["first_evaluation_time"]} #{t(:days)}") 
    end    
  end
  
  def user_info report
    content_tag :tr do
      content_tag(:td, report["username"]) <<
      content_tag(:td, report["total_rfp"]) <<
      content_tag(:td, report["total_rfp_per_status"]["rejected"]) << 
      content_tag(:td, report["total_rfp_per_status"]["accepted"]) <<
      content_tag(:td, report["total_rfp_per_status"]["pending"]) 
    end    
  end

  def sector_info report
    content_tag :tr do
      content_tag(:td, report[:name]) <<
      content_tag(:td, report[:no_companies]) <<
      content_tag(:td, report[:rejected_rfps]) <<
      content_tag(:td, report[:accepted_rfps]) 
    end    
  end
  
end
