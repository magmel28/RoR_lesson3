module UsersHelper
  def check_user_permission
    if current_user.present?
      ( @user.id == current_user.id) ? true : false
    end
  end
end
