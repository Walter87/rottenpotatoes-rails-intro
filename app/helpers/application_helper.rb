module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
   
    link_to title, {:sort => column}, {:id => "#{column}_header"}
  end
end
