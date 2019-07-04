
class test_user <  ApplicationController
    attr_accessor :rank, :suit
    def initialize(rank,suit)
        @rank = rank
        @suit = suit 
    end
end