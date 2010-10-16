module ApplicationHelper
  def page_title
    if @page_title.blank?
      "Sidetrack"
    else
      [@page_title, "Sidetrack"].join(" | ")
    end
  end
end
