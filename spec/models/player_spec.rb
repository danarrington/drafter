require 'rails_helper'

RSpec.describe Player, type: :model do

  it 'requires a name' do
    expect(Player.new(email: 'dan@email.com').valid?).to eq false
  end

  it 'requires a email' do
    expect(Player.new(name: 'Dan').valid?).to eq false
  end

  it 'normalizes name entry' do
    expect(create(:player, name: 'dan').name).to eq 'Dan'
  end
end
