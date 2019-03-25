# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Books", type: :feature do
  fixtures :users, :books
  scenario "show articles" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit root_path
    expect(page).to have_content I18n.t("books.index.listing_books")
  end

  scenario "create article" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit new_book_path
    fill_in "book_title", with: "テストタイトル"
    fill_in "book_memo", with: "テストメモ"
    fill_in "book_author", with: "山田太郎"
    attach_file "book_picture", "#{Rails.root}/spec/fixtures/book_picture.jpg"
    expect { click_on I18n.t("helpers.submit.create", model: "Book") }.to change { Book.count }.by(1)
  end

  scenario "show article" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit "/books/#{books(:first).id}"
    expect(current_path).to eq "/books/#{books(:first).id}"
  end

  scenario "update article" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit "/books/#{books(:first).id}/edit"
    fill_in "book_title", with: "更新したタイトル"
    click_on I18n.t("helpers.submit.update", model: "Book")
    expect(page).to have_content I18n.t("books.update.success")
  end

  scenario "delete article" do
    user = users(:tarou)
    login_as(user, scope: :user)
    visit root_path
    expect do
      accept_confirm { click_on I18n.t("destroy") }
      find_by_id("notice")
    end.to change { Book.count }.by(-1)
  end
end
