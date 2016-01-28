require 'rails_helper'

describe 'something' do
  it 'should be able to start a new draft' do
    visit '/'
    click_link 'Start New Draft'

    fill_in('Event Name', with: 'NCAA Tournament')
    click_button 'Add Players'
    
    expect(page).to have_content 'NCAA Tournament'
    fill_in('First Name', with: 'Dan')
    fill_in('Email', with: 'dan@email.com')
    click_button 'Add'
    
    expect(page).to have_content 'Dan'
    fill_in('First Name', with: 'Eric')
    fill_in('Email', with: 'eric@email.com')
    click_button 'Add'
    fill_in('First Name', with: 'bob')
    fill_in('Email', with: 'bob@email.com')
    click_button 'Add'
    expect(Player.count).to eq 3

    click_link 'Finish'

    fill_in('draftables', with: 'Washington, Missouri, Michigan State')
    click_button 'Submit'
    expect(Draftable.count).to eq 3

    expect(page).to have_content 'Dan'
    expect(page).to have_content 'Washington'

    click_link 'Start Draft'

  end



end
