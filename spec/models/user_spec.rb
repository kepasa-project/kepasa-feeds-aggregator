require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/user.rb'

describe User, type: :model do
    context 'validation test' do
        it 'ensures first name presence' do
                user= User.new(last_name: 'Last', email: 'sample@example.com').save
                expect(user).to equal(false)
        end
        it 'ensures last name presenceclear' do
            user= User.new(first_name: 'First', email: 'sample@example.com').save
            expect(user).to equal(false)
        end

        it 'ensures email address presence' do
            user= User.new(first_name: 'First', last_name: 'Last', email: 'sample@example.com').save
            expect(user).to equal(true)
        end

            it 'should save successfully' do
        end

    end
end