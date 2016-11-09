module ApplicationHelper
  def active_class(opt)
    return "active" if request.fullpath == opt[:link_path]
    return "active" if request[:controller] == opt[:controller]
  end

  def render_merge(str1, str2)
    (str1+str2).html_safe
  end
end
