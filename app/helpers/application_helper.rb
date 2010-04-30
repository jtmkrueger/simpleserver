# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def link_to_hide_show(link_name, toggle_id, link_id, initial_text, toggled_text)
    #link_to_function "Add", "$('tenant').toggle(); ($('add_tenant').innerHTML == 'Add') ? ($('add_tenant').innerHTML = 'Close') : ($('add_tenant').innerHTML = 'Add');", :id => "add_tenant"
    link_to_function link_name, "$('#{toggle_id}').toggle(); ($('#{link_id}').innerHTML == '#{initial_text}') ? ($('#{link_id}').innerHTML = '#{toggled_text}') : ($('add_tenant').innerHTML = 'Close');", :id => link_id
  end
  
end
