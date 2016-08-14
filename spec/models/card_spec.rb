require 'spec_helper'
require 'rails_helper'

describe "Card" do



  describe "set_review_date" do
    it "set review date to now" do
      card = FactoryGirl.create(:card)
      # card = Card.new(original_text: "Olala", translated_text: "hause")
      # card.save!
      # expect(card.set_review_date == (Date.current + 3.days) ).to be true
      expect(card.set_review_date).to eq (Date.current)
    end
  end

  describe "check_translation" do
    it "allow using camelcase" do
      card = Card.new(translated_text: "hause")
      expect(card.check_translation("Hause")[:translate_ok]).to be true
    end

    it "allow using spaces" do
      card = Card.new(translated_text: " hause ")
      expect(card.check_translation("hause")[:translate_ok]).to be true
    end
  end

    describe "success" do
      it "when first check is success" do
        @card = FactoryGirl.create(:card)
        @card.review_date = Time.current.strftime("%d/%m/%Y")
        @card.success
        expect(@card.level).to eq 1
        expect((@card.review_date).strftime("%d/%m/%Y")).to eq (Time.current + 12.hour).strftime("%d/%m/%Y")
      end

      it "when second check is success" do
        @card = FactoryGirl.create(:card)
        @card.review_date = Time.current.strftime("%d/%m/%Y")
        2.times {@card.success}
        expect(@card.level).to eq 2
        expect((@card.review_date).strftime("%d/%m/%Y")).to eq (Time.current + 3.days).strftime("%d/%m/%Y")
      end

      it "when third check is success" do
        @card = FactoryGirl.create(:card)
        3.times {@card.success}
        expect(@card.level).to eq 3
        expect((@card.review_date).strftime("%d/%m/%Y")).to eq (Time.current + 1.week).strftime("%d/%m/%Y")
      end

    end


    describe "failed" do
      it "when first check is failed" do
        @card = FactoryGirl.create(:card)
        @card.level = 3
        @card.failed
        expect(@card.level).to eq 3
        expect(@card.fail_counter).to eq 1
      end

      it "when second check is faild" do
        @card = FactoryGirl.create(:card)
        @card.level = 3
        2.times {@card.failed}
        expect(@card.level).to eq 3
        expect(@card.fail_counter).to eq 2
      end

      it "when third check is faild" do
        @card = FactoryGirl.create(:card)
        @card.level = 3
        3.times {@card.failed}
        expect(@card.level).to eq 1
        expect(@card.fail_counter).to eq 0
      end
    end



end