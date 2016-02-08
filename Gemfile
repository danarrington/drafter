source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'turbolinks'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
gem 'devise'

gem "slim-rails"
group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "faker"
  gem "dotenv-rails"
end

group :test do
  gem "capybara"
  gem "timecop"
  gem "poltergeist"
end

group :production do
  gem "pg"
end
