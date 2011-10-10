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
      content_tag(:td) do
          content_tag( :a, (link_to t(:show), "/upload/rfp/#{rfp.filename}", :target => "_blank")) 
      end <<
      content_tag(:td) do
          content_tag( :a, (link_to t(:edit),  edit_request_path(rfp)))
      end << 
      content_tag(:td) do
          content_tag( :a, (link_to t(:delete), rfp, :confirm => '¿Está seguro?', :method => :delete))
      end
    end
  end  
end
