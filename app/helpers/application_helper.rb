module ApplicationHelper
  def coach_image_tag(coach, options = {})
    if coach.image.present?
      path = coach_path(coach, format: coach.image.extension)
      image_tag(path, { alt: coach.name }.merge(options))
    else
      image_tag("no_image.png")
    end
  end
end
