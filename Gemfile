ruby '2.3.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'high_voltage', '~> 3.0'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.9', '>= 3.9.1'
gem 'rails', '~> 5.1', '>= 5.1.2'
gem 'sass', '~> 3.5', '>= 3.5.1'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'uglifier', '~> 3.2'
gem 'uswds-rails', '~> 1.3'

source 'https://rails-assets.org' do
  gem 'rails-assets-html5shiv', '3.7.3'
  gem 'rails-assets-jquery', '3.2.1'
  gem 'rails-assets-owl-carousel2', '2.2.1'
end

group :development, :test do
  gem 'brakeman', '~> 3.7', require: false
  gem 'byebug', '~> 9.0', '>= 9.0.6'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'rspec-rails', '~> 3.6'
  gem 'rubocop', '~> 0.49.1', require: false
end

group :development do
  gem 'web-console', '~> 3.5', '>= 3.5.1'
end

group :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'simplecov', '~> 0.14.1', require: false
  gem 'simplecov-console', '~> 0.4.2', require: false
end
