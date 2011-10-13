# -*- coding: utf-8 -*-
module RequestsHelper

  def general_info rfp 
    content_tag(:tr) do
      content_tag(:td, rfp.name) <<
      content_tag(:td, rfp.start_date) <<
      content_tag(:td, rfp.decision_date) <<
      content_tag(:td, rfp.company) <<
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
      content_tag(:td, "%0.2f" % report["avg"])
    end    
  end

  def statistics_request_types reports
    content_tag :table do
      content_tag(:th, t(:name))
      for report in reports do
        request_type_info(report)
      end
   end
  end
  

end
