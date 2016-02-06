require 'rails_helper'

describe 'authentication' do
  let(:player) {create(:player)}
  let(:draft) {create(:draft)}
  context 'no user signed in' do
    context 'valid credentials provided' do
      it 'should sign in the player' do
        visit pick_path(draft, player, player.authentication_token)
        expect(page).to have_content player.name
      end
    end

    context 'invalid credentials provided' do
      it 'should redirect to the sign in page' do
        visit pick_path(draft, player, player.authentication_token+'X')
        expect(page).to have_content "Invalid/expired link"
      end
    end
  end

end
