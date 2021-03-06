source 'https://rubygems.org'

ruby '2.2.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.1.1' #
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.5.3' #
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass', '3.3.7' #

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'google-analytics-rails'
gem 'rails-i18n', '4.0.9' #
gem 'carrierwave', '0.10.0'
gem 'mini_magick', '3.8.0'
gem 'rmagick', '2.16.0', :require => 'RMagick'
gem 'fog', '1.36.0'
gem 'faker', '1.4.2'
gem 'will_paginate', '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'kaminari'
gem 'jquery-turbolinks'
gem 'byebug', '8.2.5'
gem 'pry-byebug', '3.3.0'

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
  gem 'factory_girl_rails', '~> 4.4.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.7.1'
end

group :test, :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.11'
end
  
group :production, :staging do
  gem 'puma', '3.4.0'
  gem 'pg', '0.18.4'
  gem 'rails_12factor', '0.0.3'
end