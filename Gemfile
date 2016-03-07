source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'turbolinks'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
group :development do
  gem 'spring'
  gem 'letter_opener_web'
end
gem 'devise'

gem "slim-rails"
gem "bourbon", "~> 4.2"
gem "neat", "~> 1.7"
gem "premailer-rails"

group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "faker"
  gem "dotenv-rails"
  gem "byebug"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem "capybara"
  gem "capybara-email"
  gem "timecop"
  gem "poltergeist"
end

group :production do
  gem "pg", "0.18.1"
  gem "remote_syslog_logger"
end
