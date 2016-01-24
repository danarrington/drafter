require 'rails_helper'

describe 'something' do
  it 'should be able to start a new draft' do
    visit '/'
    click_link 'Start New Draft'

    fill_in('First Name', with: 'Dan')
    fill_in('Email', with: 'dan@email.com')
    click_button 'Add'


  end



end
