source 'https://rubygems.org'
ruby '2.2.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
#styling
gem 'bootstrap-sass', '~>3.3.5' #Twitter's Bootstrap

gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'figaro' #figaro for environment variables
gem 'will_paginate', '~> 3.0.6' # Easy pagination

# Handles User Authentication with Google
gem 'omniauth'
gem 'omniauth-google-oauth2'

# Handles ability for admin v mere plebian users
gem 'cancancan', '~> 1.10'

# Handles image uploading, resizing, and storage
gem 'fog'
gem 'mini_magick'
gem 'carrierwave'
gem 'sidekiq' # For Background processing (and API generally, actually....)

# Handles searching
gem 'pg_search'

group :production do
  gem 'unicorn', '4.8.3' #Unicorn for Heroku in production. for large amounts of traffic.
  gem 'rails_12factor' #Heroku highly recommends using this
  gem 'heroku_rails_deflate' #gzipper for Heroku, reduces pageload time and makes Google happy
  gem "rack-timeout" # kills long-running requests and logs exceptions related to timeouts. Suggested by Heroku.
end

group :development do
  gem 'binding_of_caller' #suggested by debugging
  gem 'better_errors' #better error debugger
  gem 'spring' #keeps app running in background, speeds up dev
  gem "letter_opener" #makes emails pop up in the browser rather than actually sending them in development mode.
  gem 'quiet_assets' # prevents logging everytime an asset's requested; cleans up server console.
end

group :development, :test do
  gem "awesome_print" # makes irb prettier, some tests can print using the prefix `ap` to get the pretty result
  # gem 'debugger'
end

group :test do
  gem 'simplecov', :require => false
end
