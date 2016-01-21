source 'https://rubygems.org'
#
gem 'rails', '3.2.18'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'feedjira'
gem 'nokogiri'
#gem 'open-uri'

# Gems used only for assets and not required
# in production environments by default.

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

# admin control panel
gem 'activeadmin'
gem 'kaminari', '~> 0.13.0'
gem "meta_search", '>= 1.1.0.pre'

#gem 'sass-rails', '~> 3.2.3'

# Blog
gem "monologue"

group :assets do
  #gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  #gem 'bootstrap-sass', '~> 2.3.2.1'
  #gem 'therubyracer'

  # here there was the bootstrap-gem
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

 # twitter bootstrap setting
  gem 'compass-rails', '1.1.7'
  gem 'sass-rails', '3.2.6'
  gem 'bootstrap-sass', '~> 3.2.0'

  
  gem 'jquery-rails'
  gem 'jquery-ui-rails'

  #tag system
  gem 'acts-as-taggable-on'

  # SEO
  gem 'friendly_id'

  group :development do

    gem 'sqlite3'
    
  end

  group :production do

    gem 'pg'
    gem 'json', '~> 1.8.1'  

  end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server

#gem 'unicorn'

# Deploy with Capistrano
#gem 'capistrano'

# To use debugger
# gem 'debugger'
