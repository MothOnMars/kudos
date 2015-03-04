require 'spec_helper'

feature 'logging in' do
  let(:org) { create(:organization, name: 'Acme, Inc.') }
  let!(:user) do
    create(:user, email: 'jane.doe@acme.com',
           password: 'password', organization: org)
  end

  it 'requires the user to log in' do
    visit root_url
    expect(page).to have_text('You need to sign in')
  end

  describe 'a successful login' do
    before do
      visit root_url
      fill_in 'user_email', with: 'jane.doe@acme.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
    end

    it 'calls the user to action' do
      expect(page).to have_text('Send someone a kudo!')
    end
  end
end
