require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

describe  "Supermemo" do

  let!(:user) { create(:user) }

  before(:each) do
    visit root_path
    login("adminadmin@admin.com", "password")
  end

  let!(:card) {create :card, review_date: Date.current, user: user}

  context

    context "if success" do
      subject { Supermemo.success_efactor(1, 2.5) }
      it { should include(:efactor => 2.6, :counter => 2) }
    end

    context "if misprint" do
      subject { Supermemo.misprint_efactor(1, 2.5) }
      it { should include(:efactor => 2.36, :counter => 2) }
    end

    context "if failed" do
      subject { Supermemo.failed_efactor(1, 2.5) }
      it { should include(:efactor => 0.5, :counter => 2) }
    end

  end
