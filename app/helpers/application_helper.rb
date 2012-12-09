module ApplicationHelper
  def title(title, opts={})
    @hide_title = opts[:hide]
    @title= title
  end

  def icon(name, white=false)
    content_tag :i, '', class: "icon-#{name.to_s.gsub("_","-")} #{'icon-white' if white}"
  end

  def pluralize_person_uses(count)
    "<strong>#{count}</strong> #{count == 1 ? "person uses" : "people use"} it".html_safe
  end

  def alert_class(type)
    case type
    when :notice
      "alert-info"
    else
      "alert-#{type}"
    end
  end

  def nav_li(opts = {})
    if opts[:at] 
      controller, action = opts.delete(:at).split("#")
      opts[:controller] = controller
      opts[:action] = action
    end
    active = true
    opts.each do |key, val|
      vals = [*val]
      passes = false
      vals.each do |val|
        passes ||= val == params[key]
      end
      active &&= passes
    end
    content_tag :li, class: "#{'active' if active}" do
      yield
    end

  end
end
