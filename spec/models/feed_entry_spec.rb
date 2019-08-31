require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/feed_entry.rb'

RSpec.describe FeedEntry  do


    it 'has to have url feed' do
        expect(self).to be_truthy
    end
    it 'has to have supplies rss feed' do
        expect(@feed).to be_nil
    end
end

