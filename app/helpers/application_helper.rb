module ApplicationHelper
  def format_video_duration(input)
    Time.at(input).utc.strftime("%H:%M:%S")
  end
end
