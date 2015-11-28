class SlackController < ApplicationController
  # Skip cancancan authorization check for this controller.
  skip_authorization_check

  # Skip Rails' check for authenticity tokens
  skip_before_action :verify_authenticity_token

  def incoming
    # These are the incoming params POSTed from Slack
    # params[:token]
    # params[:team_id]
    # params[:channel_id]
    # params[:channel_name]
    # params[:user_id]
    # params[:user_name]
    # params[:command]
    # params[:text]
    # params[:response_url]

    if params[:token] != ENV['slack_team_token']
      render :status => :forbidden, :text => "403 Forbidden: Wrong Slack Team or token"
      return
    end

    @response = Reaction.return_to_slack(params[:text])

    if @response
      # Reply with basic JSON.
      render json: {
        response_type: "in_channel",
        attachments: [
          {
            fallback: "#{params[:text]}",
            image_url: @response.image_url
          }
        ]
      }.to_json
    else
      render text: "No Match. Try adding one."
    end

    # Log the request and whether it worked out.
    @matched = @response.nil?
    Request.create!(
            text: params[:text],
            matched: @matched,
            requesting_user: params[:user_name]
            )

  end

end
