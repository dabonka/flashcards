class EqualValidator < ActiveModel::Validator
  def validate(card)
    if card
      if card.original_text.mb_chars.downcase.strip.normalize == card.translated_text.mb_chars.downcase.strip.normalize
           card.errors[:base] << "The values of original text and translated text should be different"
      end
    end
  end
end

class Card < ActiveRecord::Base

  def set_review_date
    self.review_date = DateTime.now + 3.days
  end

  scope :change_date, -> { where("review_date <= ?", Time.now).limit(1).order("RANDOM()").first}

  def check_translation(mytext)
   self.translated_text.mb_chars.downcase.strip == mytext.mb_chars.downcase.strip
  end

  before_validation :set_review_date
  validates :original_text, :translated_text, :review_date, presence: true
  validates_with EqualValidator
  
end