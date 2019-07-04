require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
#require './app/models/ability.rb'

class  Ability 
    attr_reader :user, :role
    def initialize (user,role)
        @user = user
        @role = role

    end
end
RSpec.describe Ability do
    let(:has_role) {Ability.new('kimi','admin')}

    it 'has to have role admin' do
       expect(has_role.user).to eq('kimi')
    end
    it 'has to have role admin' do
        expect(has_role.role).to eq('admin')
     end
 
end