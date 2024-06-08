module PeopleHelper
  def active_person_status active
    content_tag :span, class: "text-#{active ? 'success' : 'danger'}" do
      content_tag :i, '', class: "bi-#{active ? 'check' : 'x'}-circle"
    end
  end
end
