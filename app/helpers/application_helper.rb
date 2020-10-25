module ApplicationHelper

  def sortable(column, title = nil, additional_params = nil)
    additional_params ||= {}
  	 title ||= column.titleize
  	 css_class = column == sort_column ? "current #{sort_direction} blue" : "white"
  	 direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  	 link_to title, additional_params.merge(sort: column, direction: direction), {class: css_class}
  end
end
