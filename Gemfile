ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

source 'https://rubygems.org' do
  gem 'pg', '~> 0.21.0'
  gem 'puma', '~> 3.9', '>= 3.9.1'
  gem 'rails', '~> 5.1', '>= 5.1.2'
  gem 'sass-rails', '~> 5.0', '>= 5.0.6'
  gem 'uglifier', '~> 3.2'

  group :development, :test do
    gem 'byebug', '~> 9.0', '>= 9.0.6'
  end

  group :development do
    gem 'web-console', '~> 3.5', '>= 3.5.1'
  end
end
