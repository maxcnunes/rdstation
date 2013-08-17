source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'twitter-bootstrap-rails'

# Our Pipedrive Gem
gem 'pipedrive_rdstation', :github => 'maxcnunes/pipedrive_rdstation'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner', '<= 1.0.1' # temporarily downgraded, broken in rails 4
  gem 'capybara'
  gem 'coveralls', require: false
end

group :production do
  gem 'pg'
end