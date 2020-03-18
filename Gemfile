source 'https://rubygems.org'

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  ruby '2.5.1'

  # Bundle edge Rails instead:
  gem 'rails', '5.2.0'

  gem 'feedjira'
  gem "nokogiri", ">= 1.10.4"
  #gem 'open-uri'

  # Gems used only for assets and not required
  # in production environments by default.
  gem 'pg', '~> 0.20'
  gem 'puma', '~> 3.11'

  # auth/authorization + avatar system
  gem 'devise'
  gem 'cancancan'
  gem 'rolify'
  gem 'gravtastic'

  # integration with facebook
  # gem 'omniauth-facebook'
  # gem 'koala'

  # Monitor App
  # gem 'newrelic_rpm'

  # asynchronous jobs
  gem 'whenever', :require => false
  gem 'sidekiq'
  gem 'sinatra', require: false
  gem 'slim'

  # email and passwords system
  gem 'figaro'
  gem 'gibbon'

  # DEBUG RUBY
  #gem 'rbtrace'
  gem 'rbtrace', git: 'https://github.com/tmm1/rbtrace', branch: 'master'

#pagination
gem 'will_paginate'
>>>>>>> retrieve-image

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
  # gem 'mini_racer', platforms: :ruby
  
  # Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
  
  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'jquery-rails'
gem 'jquery-ui-rails'

#tag system
gem 'acts-as-taggable-on'

# SEO
gem 'friendly_id'

group :development, :test do

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'rubocop', '~> 0.65.0', require: false

end

group :development do

    gem 'sqlite3', '~> 1.3.6'
    gem 'web-console', '~> 3.5.1'
    gem 'listen', '>= 3.0.5', '< 3.2'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'

    # capistrano env gem
    gem 'capistrano', '~> 3.7', '>= 3.7.1'
    gem 'capistrano-figaro'
    gem 'capistrano-rails', '~> 1.2'
    gem 'capistrano-passenger', '~> 0.2.0'
    gem 'capistrano-rbenv', '~> 2.1'
    gem 'capistrano-rails-db'

end

group :production do

    gem 'json', '~> 1.8.1'  

end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

gem "font-awesome-rails"
gem "foreman"
gem 'carrierwave', '~> 1.0'
gem "mini_magick", ">= 4.9.4"

# fetch resources from feed
gem 'link_thumbnailer'
gem 'httparty', '~> 0.13.7'
gem 'onebox'
gem 'metainspector'

#
gem 'rails-timeago', '~> 2.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# social
gem 'social-share-button'

# Use unicorn as the app server
#gem 'unicorn'

# Deploy with Capistrano
#gem 'capistrano'

# To use debugger
# gem 'debugger'