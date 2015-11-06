module UsersHelper
  def check_user_permission
    (@user.id == current_user.id) ? true : false
  end
end
