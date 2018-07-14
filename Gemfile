# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.2'

gem 'activeadmin'
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'knock'
gem 'pg', '~> 1.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.0'

# gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 4.0'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'pry'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
