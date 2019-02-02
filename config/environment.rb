# Load the rails application
Encoding.default_external = Encoding::UTF_8 # added for 
Encoding.default_internal = Encoding::UTF_8 # Feedjira
require_relative 'application'
require 'rbtrace'

# Initialize the rails application
Rails.application.initialize!

ENV['GEM_HOME']='/home/deployer/.gem/ruby/2.1.0'
ENV['GEM_PATH']='/home/deployer/.rbenv/versions/2.1.0/lib/ruby/gems/2.1.0'

