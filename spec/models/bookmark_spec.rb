require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/bookmark.rb'

RSpec.describe  'Bookmark' do
    it 'has to be taggable' do
        expect(@acts_as_taggable_on).to be_nil
    end
end