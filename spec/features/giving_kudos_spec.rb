require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "giving kudos" do
  context 'when the user is logged in' do
    let(:org) { create(:organization) }
    let(:user) { create(:user, organization: org) }
    let!(:another_user) { create(:user, email: 'awesome.employee@example.com', organization: org) }

    before(:each) { login_as(user) }

    it 'sends someone a kudo' do
      visit root_url

      fill_in "email", with: 'awesome.employee@example.com'
      fill_in "kudo_message", with: "you're awesome!"
      click_button "Send Kudo"

      expect(page).to have_text("Your kudo was sent")
    end

    it 'informs the user if the recipient is not found' do
      visit root_url

      fill_in "email", with: 'nobody@example.com'
      fill_in "kudo_message", with: "you're awesome!"
      click_button "Send Kudo"

      expect(page).to have_text("Unable to find a user with that email address")
    end

    context 'when the user has sent 3 kudos that week' do
      before do
        3.times { user.sent_kudos.create!(message: 'you rock!', recipient: another_user) }
      end

      it 'informs the user they have sent the max kudos' do
        visit root_url
        expect(page).to have_text("You've sent kudos to 3 people this week")
      end
    end
  end
end
