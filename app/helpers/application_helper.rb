module ApplicationHelper

  def profile_image_for(user, options = {})
    size = options[:size] || 80
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(url, alt: user.name)
  end

  def page_title
    if content_for?(:title)
      "Events - #{content_for(:title)}"
    else
      "Events"
    end
  end
end
