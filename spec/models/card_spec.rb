require 'spec_helper'
require 'rails_helper'

describe "Card" do



  describe "set_review_date" do
    it "set review date to now + 3 days" do
      card = FactoryGirl.create(:card)
      # card = Card.new(original_text: "Olala", translated_text: "hause")
      # card.save!
      # expect(card.set_review_date == (Date.current + 3.days) ).to be true
      expect(card.set_review_date).to eq (Date.current + 3.days)
    end
  end

  describe "check_translation" do
    it "allow using camelcase" do
      card = Card.new(translated_text: "hause")
      expect(card.check_translation("Hause")).to be true
    end

    it "allow using spaces" do
      card = Card.new(translated_text: " hause ")
      expect(card.check_translation("hause")).to be true
    end

    describe "success" do
      true
    end

    describe "failed" do
      true
    end


  end
end