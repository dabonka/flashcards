require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

describe  "Decks", :type => :feature do

  let!(:user) { create(:user) }

  before(:each) do
    login("adminadmin@admin.com", "password")
  end

  let!(:deck) {create :deck, user: user} # Запускаем фабрику создания колоды, созданное значение действительно до конца describe  "Decks"

  it  "Input new deck" do
    visit new_deck_path
    fill_in 'deck_title', :with => 'Повседневная колода'
    click_button 'Create Deck'
    expect(page).to have_content 'List decks'
  end

  it  "Select current deck" do
    visit decks_path
    click_link 'Make current'
    expect(page).to have_content 'Current'
  end


end
