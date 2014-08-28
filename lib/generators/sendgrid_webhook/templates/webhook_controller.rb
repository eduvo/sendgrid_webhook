class WebhookController < ApplicationController
  protect_from_forgery with: :null_session

  skip_before_action :authenticate_user!
  skip_before_action :check_current_user
  skip_before_action :verify_authenticity_token

  def email
    render :nothing => true
  end
end
