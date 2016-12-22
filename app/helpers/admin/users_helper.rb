module Admin::UsersHelper
  def activity_button_title(user)
    user.active ? 'Active' : 'Deactive'
  end
end
