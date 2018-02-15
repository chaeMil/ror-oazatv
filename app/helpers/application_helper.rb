module ApplicationHelper
  def format_video_duration(input)
    Time.at(input).utc.strftime("%H:%M:%S")
  end

  def nav_link(link_text, link_path, li_class, a_class)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => "#{li_class} #{class_name}") do
      link_to link_text, link_path, class: a_class
    end
  end
end
