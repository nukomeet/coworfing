require 'spec_helper'
include Warden::Test::Helpers

describe "Places" do
  let(:regular) { FactoryGirl.create(:user, :regular) }

  describe "Manage places" do
    it "adds a new place and display the results" do
      login_as regular, scope: :user
      visit places_url
      expect {
        click_link 'Add a place'

        fill_in 'Name', with: 'Zaiste! Place'
        fill_in 'Address', with: '19 Rue de Temple'
        fill_in 'City', with: 'Paris'
        select 'France', from: 'Country'
        fill_in 'Description', with: 'This is the best place to coworf'
        select 'Private', from: 'Kind'

        click_button 'Create Place'
      }.to change(Place, :count).by(1)

      page.should have_content "Great, your place was successfully created."

      within 'h2' do
        page.should have_content 'Zaiste! Place'
      end

      page.should have_content 'This is the best place to coworf'

    end
  end
end
