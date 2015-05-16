class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout 'application'

  # devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :gender, :formally, :consent, :email, :password, :password_confirmation, :remember_me) }

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:firstname, :lastname, :gender, :formally, :consent, :email, :password, :remember_me) }

    devise_parameter_sanitizer.for(:invite) { |u| u.permit(:firstname, :lastname, :gender, :formally, :consent, :email) }
  end

  skip_filter :authenticate_client!, :if => lambda {
    if params[:id]
      @event = Event.find(params[:id])
      @event and @event.public?
    else
      false
    end
  }
end
