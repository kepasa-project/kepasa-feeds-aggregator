require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/ability.rb'

Rspec.describe Ability do
    it 'has to have role' do
        userlogged = Ability.new('role','admin')
        expect(userlogged.role).to eq(role);
    end
end