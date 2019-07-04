require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/controllers/test_user.rb'
#class Card
#    attr_accessor :rank, :suit
#    def initialize(rank,suit)
#        @rank = rank
#        @suit = suit 
#    end
#end

RSpec.describe  Card do
        ###this block works
        #def card
        #        Card.new('Ace','Spades')
        #end
        ####

        let(:card) { Card.new('Ace','Spades') }

        it 'has a rank that can be change' do
            expect(card.rank).to eq('Ace')
            card.rank = 'Queen'
            expect(card.rank).to eq('Queen')
        end
        it 'has a suit' do
            expect(card.suit).to eq('Spades')
        end
        it 'has a custom error message' do
            comparison = 'Spades'
            expect(card.suit).to eq(comparison),"Hey, I expected #(comparison) but i got #(card.suit) instead!"

        end
 
        
end