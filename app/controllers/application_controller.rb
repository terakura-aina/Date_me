class ApplicationController < ActionController::Base
  # CSRF保護を無効にする
  protect_from_forgery with: :null_session
end
