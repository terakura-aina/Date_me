module SchedulesHelper
  def current_user
    if session[:user_id]
      #値がnilであればUser.find_by(id: session[:user_id])が代入される
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
