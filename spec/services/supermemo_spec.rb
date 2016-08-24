require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

describe  "Supermemo" do

  let!(:user) { create(:user) }

  before(:each) do
    @card = create(:card, user: user, efactor: 2.5, counter: 1)
    @in_a_day = (Time.current + 1.day).strftime("%d/%m/%Y")
    @in_a_5_days = (Time.current + 5.day).strftime("%d/%m/%Y")
    @in_a_6_days = (Time.current + 6.day).strftime("%d/%m/%Y")
  end

    context "if success_efactor" do
      subject { Supermemo.success_efactor(1, 2.5) }
      it { should include(efactor: 2.6, counter: 2) }
    end

    context "if misprint_efactor" do
      subject { Supermemo.misprint_efactor(1, 2.5) }
      it { should include(efactor: 2.36, counter: 2) }
    end

    context "if failed_efactor" do
      subject { Supermemo.failed_efactor(1, 2.5) }
      it { should include(efactor: 0.5, counter: 2) }
    end

    context "if success_calc with quality 5 (success)" do
      subject { Supermemo.success_calc(1, 5, 2.5) }
      it { should include(efactor: 2.6, counter: 2) }
    end

    context "if success_calc with quality 5 (misprint)" do
      subject { Supermemo.success_calc(1, 3, 2.5) }
      it { should include(efactor: 2.36, counter: 2) }
    end

    context "check calculate_efactor"do

        it "if calculate_efactor with quality 5 (success)" do
          expect(Supermemo.calculate_efactor(5, 2.5)).to eq 2.6
        end

        it "if calculate_efactor with quality 3 (misprint)" do
          expect(Supermemo.calculate_efactor(3, 2.5)).to eq 2.36
        end
    end

    context "check renew_interval" do

        it "if renew_interval calculate review_date with counter eq 1, efactor eq 2.5" do
          expect(Supermemo.renew_interval(1, 2.5)).to eq @in_a_day
        end

        it "if renew_interval calculate review_date with counter eq 2, efactor eq 2.5" do
          expect(Supermemo.renew_interval(2, 2.5)).to eq @in_a_6_days
        end

        it "if renew_interval calculate review_date with counter eq 3, efactor eq 2.5" do
          expect(Supermemo.renew_interval(3, 2.5)).to eq @in_a_5_days
        end

    end
  end
