require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

describe  "Cards", :type => :feature do

  let!(:user) { create(:user) }

  before(:each) do
    login("admin@admin.com", "password")
  end

  let!(:card) {create :card, review_date: Date.current, user: user} # Запускаем фабрику создания карточки, созданное значение действительно до конца describe  "Cards"

  it  "Input new card" do
    visit new_card_path
    fill_in 'card_original_text', :with => 'Windows'
    fill_in 'card_translated_text', :with => 'Okna'
    click_button 'OK'
    expect(page).to have_content 'Original Text'
  end

  # it  "check_translation" do
  #  visit root_path
  #  fill_in 'user_variant', with: :card_translated_text
  #  click_button 'Проверить!'
  #  expect(page).to have_content 'Флэшкарточкер'
  #end
end
