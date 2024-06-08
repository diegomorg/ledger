module ApplicationHelper
  def notice_success
    content_tag(:div, notice, class: "alert alert-success") if notice.present?
  end
end
