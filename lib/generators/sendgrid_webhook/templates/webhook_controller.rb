class <%= controller_name.camelize %>Controller < ApplicationController
  protect_from_forgery with: :null_session

  skip_before_action :authenticate_user!
  skip_before_action :check_current_user
  skip_before_action :verify_authenticity_token

  def email
    # handle the webhook callback here.
    # params["_json"].group_by{|rsp| rsp["<%= model_name.underscore %>_id"]}.each do |<%= model_name.underscore %>_id, rsp_hash|
    #   last_email_rsp = rsp_hash.sort_by{|h| h["timestamp"]}.last
    #
    #   if last_email_rsp["env"] == Rails.env
    #     <%= model_name %>.find(<%= model_name.underscore %>_id).update_attributes(:status => last_email_rsp["event"])
    #   end
    # end
    render :nothing => true
  end
end
