Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["google_client_id"], ENV["google_client_secret"],
  	{
      :prompt => "select_account",
    }
end
