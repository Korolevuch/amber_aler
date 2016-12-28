module ApplicationHelper

  def sanitize_wysiwyg(text, shorten: nil)
    res = sanitize(text, tags: %w(p strong em u table thead tbody th tr td h4 h5 h6 pre br hr ul ol li blockquote), attributes: %w(id class style))
    res = truncate_html(res, length: shorten, omission: '...') if shorten.present?
    res
  end

  def set_avatar(user)
    if user.avatar?
      image_tag(user.avatar.url, size: 80, class: "circular-image" )
    else
      image_tag('photo.jpg', size: 80, class: "circular-image")
    end
  end

  def user_status?(user)
    status_online_for?(user) ? User::ONLINE : User::OFFLINE
  end

  private

  def status_online_for?(user)
    time_difernt = user.last_activity - Time.now
    time_difernt.abs < 450 && user.online
  end
end
