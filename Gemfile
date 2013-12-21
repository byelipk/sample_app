source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'bcrypt-ruby', '3.0.1'
#gem 'bootstrap-sass', '2.1'
gem 'faker', '1.0.1'
#gem 'will_paginate', '3.0.3'
#gem 'bootstrap-will_paginate', '0.0.6'
gem 'jquery-rails', '3.0.4'
gem 'strong_parameters'

# PostgreSQL database
gem "pg", "~> 0.17"

group :development, :test do
  #gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
end

group :development do
  # For annotating db schema and model
  gem 'annotate', '2.5.0'
  
  # Debugging tools 
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'   

  # For generating ActiveRecord model diagrams
  gem "rails-erd"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0' 
  gem 'launchy', '2.1.0' 
end
