ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'activerecord-import', '~> 0.22.0', require: false
gem 'friendly_id', '~> 5.2', '>= 5.2.3'
gem 'geokit-rails', '~> 2.3'
gem 'health_check', '~> 3.0'
gem 'high_voltage', '~> 3.0'
gem 'jbuilder', '~> 2.7'
gem 'lograge', '~> 0.9.0'
gem 'pg', '~> 1.0'
gem 'puma', '~> 3.11', '>= 3.11.3'
gem 'rails', '~> 5.1', '>= 5.1.5'
gem 'roo', '~> 2.7.1', require: false
gem 'sass', '~> 3.5', '>= 3.5.5'
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
gem 'uglifier', '~> 4.1', '>= 4.1.8'
gem 'uswds-rails', '1.4.6'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'

source 'https://rails-assets.org' do
  gem 'rails-assets-html5shiv', '3.7.3'
  gem 'rails-assets-jquery', '3.3.1'
  gem 'rails-assets-leaflet', '1.3.1'
  gem 'rails-assets-owl-carousel2', '2.2.1'
end

group :development, :test do
  gem 'brakeman', '~> 4.2', require: false
  gem 'byebug', '~> 10.0'
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'rubocop', '~> 0.54.0', require: false
end

group :test do
  gem 'capybara', '~> 2.18'
  gem 'chromedriver-helper', '~> 1.2'
  gem 'selenium-webdriver', '~> 3.11'
  gem 'simplecov', '~> 0.16.1', require: false
  gem 'simplecov-console', '~> 0.4.2', require: false
end
