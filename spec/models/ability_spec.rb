require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/ability.rb'

RSpec.describe Ability do
#    before do
 #       @userlogged = Ability.new(@user,'admin')        
  #  end

    it 'has to be admin' do
        @user.has_role? :admin
        expect(@user.role).to eq('admin');
    end
    it 'has to have role admin' do
        expect(@userlogged.role).to eq('admin');
    end
end