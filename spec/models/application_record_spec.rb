require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/application_record.rb'

RSpec.describe 'self_abstract' do
    it 'has to be a self ' do
        expect(self.abstract_class?).to eq(true)
    end
end