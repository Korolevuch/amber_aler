section
  div.col-md-4.red
    - if @user.avatar?
        = image_tag @user.avatar.url
    - else
        = image_tag("photo.jpg")
    h1 ==@user.name
    h4 ==@user.email
  div.col-md-5

    - @user.emergencies.each do |em|
      ul.list-group
        li.list-group-item.disabled
          span.badge = em.messages.count if @user == current_user
          = link_to  "#{em.title}", emergency_path(em)
