require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/bookmark.rb'

RSpec.describe  'Bookmark' do
    it 'has to be taggable' do
        expect(@acts_as_taggable_on).to be_nil
    end
    it 'should have user ' do
        expect(@belongs_to).to be_nil
    end
    it 'should validate presence of url ' do
        expect(:url).to be_truthy
    end
    it 'should validate presence of title ' do
        expect(:title).to be_truthy
    end
    it 'should validate presence of tag ' do
        expect(:tag_list).to be_truthy
    end

end