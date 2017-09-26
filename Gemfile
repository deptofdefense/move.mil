ruby '2.3.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'active_link_to', '~> 1.0', '>= 1.0.5'
gem 'friendly_id', '~> 5.2', '>= 5.2.2'
gem 'geokit-rails', '~> 2.3.0'
gem 'high_voltage', '~> 3.0'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.10'
gem 'rails', '~> 5.1', '>= 5.1.4'
gem 'sass', '~> 3.5', '>= 3.5.1'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'uglifier', '~> 3.2'
gem 'uswds-rails', '~> 1.3'

source 'https://rails-assets.org' do
  gem 'rails-assets-html5shiv', '3.7.3'
  gem 'rails-assets-jquery', '3.2.1'
  gem 'rails-assets-leaflet', '1.2.0'
  gem 'rails-assets-owl-carousel2', '2.2.1'
end

group :development, :test do
  gem 'brakeman', '~> 3.7', require: false
  gem 'byebug', '~> 9.1'
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'rspec-rails', '~> 3.6'
  gem 'rubocop', '~> 0.50.0', require: false
end

group :development do
  gem 'database_cleaner'
  gem 'web-console', '~> 3.5', '>= 3.5.1'
end

group :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'simplecov', '~> 0.15.1', require: false
  gem 'simplecov-console', '~> 0.4.2', require: false
end
