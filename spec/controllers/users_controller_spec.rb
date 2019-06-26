
class Card
    attr_reader :rank, :suit
    def initialize(rank,suit)
        @rank = rank
        @suit = suit 
    end
end
RSpec.describe  Card do
        before do
            #puts "Hey, I am doing a test here before its block"
            #need to have the @ sign to be recognize as instances that can be read on the blocks

            @card = Card.new('Ace','Spades')
            
        end

        it 'has a rank' do
            expect(@card.rank).to eq('Ace')
        end
        it 'has a suit' do
            expect(@card.suit).to eq('Spades')
        end
  
end