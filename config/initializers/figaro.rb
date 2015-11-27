
# These are the ENV variables required to run the app. Listing them here makes them
# required on app initialization to catch errors before pushing to production.
Figaro.require_keys(
  "google_client_id",
  "google_client_secret",
  "s3_key_id",
  "s3_secret",
  "admin_email"
  )
