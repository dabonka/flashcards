require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

describe  "Users", :type => :feature do

  describe "Create new user" do

    it  "Create new user with correct data" do
      visit new_user_path
      fill_in 'user_email', :with => 'example@example.com'
      fill_in 'user_password', :with => '123123321321'
      fill_in 'user_password_confirmation', :with => '123123321321'
      click_button 'Create User'
      expect(page).to have_content 'Exit'
    end

    it  "Create new user with correct data" do
      visit new_user_path
      fill_in 'user_email', :with => 'example@example.com'
      fill_in 'user_password', :with => '123123321321'
      fill_in 'user_password_confirmation', :with => '123123321321'
      click_button 'Create User'
      expect(page).to have_content 'Exit'
    end

    it  "Edit user with correct data with en locale" do
      visit new_user_path
      fill_in 'user_email', :with => 'example@example.com'
      fill_in 'user_password', :with => '123123321321'
      fill_in 'user_password_confirmation', :with => '123123321321'
      page.select 'en', :from => 'user_locale'
      click_button 'Create User'
      expect(page).to have_content 'Exit'
    end

    it  "Edit user with correct data with ru locale" do
      visit new_user_path
      fill_in 'user_email', :with => 'example@example.com'
      fill_in 'user_password', :with => '123123321321'
      fill_in 'user_password_confirmation', :with => '123123321321'
      page.select 'ru', :from => 'user_locale'
      click_button 'Create User'
      expect(page).to have_content 'Выйти'
    end

  end

  describe  "Login user" do

    it  "Login user with invalid data" do
      visit login_path
      click_on 'ru'
      fill_in 'email', :with => '123123321321'
      fill_in 'password', :with => '123123321321'
      check 'remember'
      click_on ('Логин')
      expect(page).to have_content 'Ошибка при входе'
    end


    it "Login user with correct data" do
      user = FactoryGirl.create(:user)
      visit login_path
      click_on 'ru'
      fill_in 'email', :with => user.email
      fill_in 'password', :with => 'password'
      check 'remember'
      click_on ('Логин')
      expect(page).to have_content 'Вход произведен успешно'
    end
  end

end