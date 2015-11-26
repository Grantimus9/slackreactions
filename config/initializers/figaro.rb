
# These are the ENV variables required to run the app. Listing them here makes them
# required on app initialization to catch errors before pushing to production.
Figaro.require_keys(
  "google_client_id",
  "google_client_secret",
  "google_storage_access_key_id",
  "google_storage_secret_access_key",
  "admin_email"
  )
