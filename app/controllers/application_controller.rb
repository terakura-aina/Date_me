class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

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
