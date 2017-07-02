source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '1.0.0.beta1'
gem 'hanami-model', '~> 1.0.0.beta1'
gem 'hanami-controller'
gem 'hanami-view'

gem 'pg'
gem 'sidekiq', '~> 4.0.2'
gem 'facebook-messenger'

gem 'hanami-assets'
gem 'hanami-bootstrap'
gem 'i18n'
gem 'faraday'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'pry'
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
