class Card
    attr_reader :type
    def initialize(rank,suit)
        @type = type
    end
end
RSpec.describe  Card do

        it 'has to be' do
            card = Card.new('Ace',Spades)
            expect(card.rank).to eq('Ace')
        end

end