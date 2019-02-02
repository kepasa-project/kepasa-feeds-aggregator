RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
     warden.authenticate! scope: :user
  end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.included_models = ['ActsAsTaggableOn::Tag','Bookmark','Category','Feed','Feedlist','RecommendedFeed','User']

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Feed do

    edit do
      field :rssurl
      field :title
      field :tags do
        orderable true
      end
    end

  end

#=begin
  config.model Category do

    edit do
      field :name
      field :language
      field :category_logo, :carrierwave
      field :recommended_feeds do
        orderable true
      end
    end

  end
#=end
  
  config.model RecommendedFeed do

=begin
    edit do
      field :rssurl
      field :categories do
        required true
      end
      field :tags do
        required true
        orderable true
      end
    end
=end
    
    edit do
      field :rssurl
      field :categories do
        orderable true
      end
      field :tags do
        orderable true
      end
    end

    list do
      field :id
      field :rssurl
      field :title
      field :categories
      field :tags
    end
  end

  config.model ActsAsTaggableOn::Tag do 

    edit do
      exclude_fields :taggings_count
    end

    list do
      field :id
      field :name
      field :taggings_count
    end
  end
  
end