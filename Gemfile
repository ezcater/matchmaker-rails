ruby "2.7.2"
source 'https://ezcater.jfrog.io/ezcater/api/gems/ezcater-gem-source'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.3'
gem 'ezcater_migrations', '>= 0.9.0'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'sprockets'
gem 'ezcater_feature_flag-client', '>= 0.6.0'
gem 'required_env_fetcher'
gem 'private_attr', require: 'private_attr/everywhere'
gem 'lograge'
gem "haml-rails", "~> 2.0"
gem 'ice_nine', require: ["ice_nine", "ice_nine/core_ext/object"]
gem 'ezcater_trusted_proxies-rails'
gem 'ezcater_metrics'
gem 'ezcater_http'
gem 'ezcater_errors'
gem 'ezcater_apm'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faker'


group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'factory_bot_rails'
  gem 'ezcater_rubocop', '>= 0.52.7', require: false
  gem 'dotenv-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'annotate'
  gem 'ezcater_docker_shared'
  gem 'overcommit', require: false
  gem 'foreman', require: false
  gem 'spring-commands-rubocop'
  gem 'spring-commands-rspec'
  gem 'aws-sdk-s3', require: false
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'webmock'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
  gem 'rspec_junit_formatter'
  gem 'ezcater_matchers'
end

gem 'foundation-rails'
gem 'autoprefixer-rails'
