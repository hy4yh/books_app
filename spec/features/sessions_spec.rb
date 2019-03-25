# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Sessions", type: :feature do
  fixtures :users
  scenario "login" do
    users(:tarou)
    visit root_path
    fill_in "user_email", with: "tarou@example.com"
    fill_in "user_password", with: "password"
    click_button I18n.t("devise.sessions.new.sign_in")
    expect(page).to have_content I18n.t("devise.sessions.signed_in")
  end

  scenario "logout" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit root_path
    click_on "sign out"
    expect(page).to have_content I18n.t("devise.failure.unauthenticated")
  end

  scenario "facebook omniauth sign up and login" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = nil
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "123545",
      info: {
        name: "mockuser",
        email: "test_omniauth@gmail.com"
      }
    )
    visit root_path
    expect do
      click_on I18n.t("devise.shared.links.sign_in_with_provider", provider: "Facebook")
      find_by_id("notice")
    end.to change { User.count }.by(1)
  end
end
