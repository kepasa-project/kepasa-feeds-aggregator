require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/ability.rb'

#class  Ability 
    #attr_accessor  :user, :role
    #def initialize (user,has_role)
    #    @user = user
    #    @has_role = has_role

    #end
#end
RSpec.describe Ability do
    let(:user) { Ability.new('kimi','admin') }

    it 'has to have user name ' do
        expect(user.user).to eq('kimi')
     end
     it 'has to have user role ' do
        expect(user.has_role).to eq('admin')
     end
 
#     it 'has to has to be admin ' do
#        expect(user.has_role?).to be_truthy
#     end
 
end