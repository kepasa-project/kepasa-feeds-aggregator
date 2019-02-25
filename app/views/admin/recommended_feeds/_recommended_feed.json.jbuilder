json.extract! recommended_feed, :id, :rssurl, :title, :category_id, :created_at, :updated_at
json.url recommended_feed_url(recommended_feed, format: :json)
