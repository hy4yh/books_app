# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Users", type: :feature do
  fixtures :users
  scenario "sign up" do
    visit new_user_registration_path
    fill_in "user_name", with: "yamada tarou"
    attach_file "user_avatar", "#{Rails.root}/spec/fixtures/profile_img.jpg"
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    expect { click_on "Sign up" }.to change { User.count }.by(1)
    expect(page).to have_content I18n.t("devise.registrations.signed_up")
  end

  scenario "delete account" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit root_path
    click_on "acount update"
    expect do
      accept_confirm { click_on "Cancel my account" }
      find(".alert")
    end.to change { User.count }.by(-1)
    expect(page).to have_content I18n.t("devise.failure.unauthenticated")
  end

  scenario "update account" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit "/users/edit"
    fill_in "user_name", with: "更新した名前"
    fill_in "user_current_password", with: "password"
    click_on "Update"
    expect(page).to have_content I18n.t("devise.registrations.updated")
  end
end
