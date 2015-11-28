class SlackController < ApplicationController
  # Skip cancancan authorization check for this controller.
  skip_authorization_check

  # Skip Rails' check for authenticity tokens
  skip_before_action :verify_authenticity_token

  # Verify it's from the right team.
  before_action :verify_slack_team

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

    case
    # starts with Add or add : The user is trying to add a gif to the library from Slack
    # with the syntax "/r add url_of_image keywords keywords keywords"
    when params[:text].match(/^add/i)

      # Make sure user has an account with the app already, and that the app knows which account the params[:user_name] is associated with.
      @user = User.find_by(slack_username: params[:user_name])
      if !@user || @user.slack_user_name.empty?
        render text: "You need to login and confirm your slack username here: #{request.base_url} before you can add reactions from within Slack."
        return
      end

      # Create the Reaction belonging to the @user, first by parsing the input text into the pieces.
      text = params[:text].sub(/add\s/i, "") # Remove prefix 'add'
      url = text.strip.match(/([^\s]+)/)[0] # grab first 'word' before a space (The URL)
      keywords = text.sub(url, "").strip # grab everything after the URL and remove preceding/trailing spaces

      @reaction = @user.reactions.create( remote_image_url: url, keywords: keywords )

      if @reaction.save
        render json: {
          text: "Successfully added image with keywords: #{@reaction.keywords}",
          attachments: [
            {
              fallback: "Successfully Added Image",
              image_url: @reaction.image_url
            }
          ]
        }.to_json
      else
        render text: "Couldn't save that - is it the right format and URL? Try uploading it here: #{request.base_url}"
      end

    # Case: User is confirming their slack username by sending their @user.confirm_code with
    # the syntax '/r confirm myconfirmcode'
    when params[:text].match(/^confirm/i)

      code = params[:text].sub(/confirm\s/i, "").strip # Remove prefix 'confirm' and strip to only get the code.

      # Make sure the user has an account.
      @user = User.find_by(slack_username: params[:user_name])
      if !@user
        render text: "You need to create an account here: #{request.base_url} first"
        return
      end

      if @user.confirm_code == code
        @user.slack_user_name = params[:user_name]
        @user.save!
        render text: "Awesome: Your username #{params[:user_name]} is now linked with account #{@user.email}. You can now use '/r add URL keywords' to add images and keywords from within Slack"
      else
        render text: "That doesn't match. Please Try Again"
      end

    # If it doesn't match a command keyword, it's a gif request.
    else
      # Reaction model has the gif search and choosing logic.
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
        render text: "No Match. Try adding one: #{request.base_url}"
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

  def verify_slack_team
    if params[:token] != ENV['slack_team_token']
      render :status => :forbidden, :text => "403 Forbidden: Wrong Slack Team or token"
      return
    end
  end

end
