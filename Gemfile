source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead:
gem 'rails', '5.1.0'

gem 'feedjira'
gem 'nokogiri'
#gem 'open-uri'

# Gems used only for assets and not required
# in production environments by default.
gem 'pg', '~> 0.20'

gem 'puma', '~> 3.7'

# auth and avatar system
gem 'devise'
gem 'gravtastic'

# integration with facebook
gem 'omniauth-facebook'
gem 'koala'

# Monitor App
gem 'newrelic_rpm'

# asynchronous jobs
gem 'whenever', :require => false
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# email and passwords system
gem 'figaro'
gem 'gibbon'

# DM system
gem 'mailboxer'

# DEBUG RUBY
#gem 'rbtrace'
gem 'rbtrace', git: 'https://github.com/tmm1/rbtrace', branch: 'master'

gem 'inherited_resources'
# admin control panel
gem 'activeadmin'
gem 'kaminari'

#gem "meta_search", '>= 1.1.0.pre'

#gem 'sass-rails', '~> 3.2.3'

# Blog
#gem "monologue"

 # front-end setting
  gem 'compass-rails', github: 'compass/compass-rails'
  gem 'sass-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 3.2.0'

  # See https://github.com/rails/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby
  
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.2'
  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  gem 'turbolinks', '~> 5'

  gem 'jquery-ui-rails'

  #tag system
  gem 'acts-as-taggable-on'

  # SEO
  gem 'friendly_id'

  group :development, :test do

    gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    # Adds support for Capybara system testing and selenium driver
    gem 'capybara', '~> 2.13.0'
    gem 'selenium-webdriver'
  
  end

  group :development do

    gem 'sqlite3'
    gem 'web-console', '~> 2.0'
    gem 'listen', '>= 3.0.5', '< 3.2'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'

  end

  group :production do

    gem 'json', '~> 1.8.1'  

  end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring'

# Use unicorn as the app server

#gem 'unicorn'

# Deploy with Capistrano
#gem 'capistrano'

# To use debugger
# gem 'debugger'
