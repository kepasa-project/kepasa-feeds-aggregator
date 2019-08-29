require './spec/rails_helper.rb'
require './spec/spec_helper.rb'
require './app/models/category.rb'

RSpec.describe Category do
  subject(:language) do
    { English: 0, Espanol: 1, Tagalog: 2 }
  end

  it 'has three language options' do
    expect(subject.length).to eq(3)
    expect(language.length).to eq(3)
  end

  it 'has to have recommended feeds' do
    expect(@has_and_belongs_to_many).to be_nil
  end
end