class ApplicationController < ActionController::Base
  helper_method :current_user
  # CSRF保護を無効にする
  protect_from_forgery with: :null_session

  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def current_user
    if session[:user_id]
      #値がnilであればUser.find_by(id: session[:user_id])が代入される
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  private

  def render_404
    render file: Rails.root.join('public', '404.html'), layout: false, status: :not_found
  end

  def render_500(error = nil)
    # log/development.logに記録される
    logger.error(error.message)
    logger.error(error.backtrace.join('\n'))
    render file: Rails.root.join('public', '500.html'), layout: false, status: :internal_server_error
  end
end
