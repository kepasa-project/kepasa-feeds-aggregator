require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/user.rb'

RSpec.describe User do
    context 'validation tests' do
        it 'ensures first name presence' do
               # user = User.new(@last_name: 'Last', @email: 'sample@example.com').save
               user = User.new(@first_name)
                expect(user).to equal(false)
        end
        it 'ensures last name presenceclear' do
            #user= User.new(@first_name: 'First', @email: 'sample@example.com').save
            user = User.new(@first_name, @email).save
            expect(user).to equal(false)
        end

        it 'ensures email address presence' do
            #user= User.new(@first_name: 'First', @last_name: 'Last', @email: 'sample@example.com').save
            user = User.new(@first_name, @last_name, @email).save
            expect(user).to equal(true)
        end

            it 'should save successfully' do
        end

    end
end