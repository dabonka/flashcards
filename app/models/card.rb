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
  belongs_to :user
  has_one    :deck

  before_create :set_review_date

  has_attached_file :avatar, styles: { medium: "360x360>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  require "damerau-levenshtein"

  def set_review_date
    self.review_date = Date.current
  end

  scope :cards_for_learn, -> (u) { where("review_date <= ? AND user_id = ?", Time.now, u.id).limit(1).order("RANDOM()")}
  scope :cards_for_learn_by_current_deck, -> (u) { where("review_date <= ? AND user_id = ? AND deck_id = ?", Time.now, u.id, u.current_deck_id).limit(1).order("RANDOM()")}

  def check_translation(mytext)
    if check_misprint(mytext) < 1
     { translate_ok: true, user_version: mytext, original_text: self.original_text, translated_text: self.translated_text }
    elsif check_misprint(mytext) == 1
      { misprint_ok: true, user_version: mytext, original_text: self.original_text, translated_text: self.translated_text }
    else
      { translate_false: true, user_version: mytext, original_text: self.original_text, translated_text: self.translated_text }
    end
  end



  def check_misprint(mytext)
    DamerauLevenshtein.distance(self.translated_text.mb_chars.downcase.strip, mytext.mb_chars.downcase.strip)
  end

  def success
    self.review_date = Time.current + case self.level
      when 0
        12.hour
      when 1
        3.days
      when 2
        1.week
      when 3
        2.weeks
      when 4
        1.month
      else
        1.month
    end
    self.level += 1 if self.level < 5 # Level 5 the highest possible cards level
    save!
  end

  def failed
    if self.fail_counter < 2
      self.fail_counter +=1
    else
      case level
        when 0..2
          self.level = 0
          self.review_date = Time.current
        when 3
          self.level = 1
          self.review_date = Time.current + 12.hour
        when 4
          self.level = 2
          self.review_date = Time.current + 3.days
        when 5
          self.level = 3
          self.review_date = Time.current + 1.week
      end
      self.fail_counter = 0
    end
    save!
  end


  validates :original_text, :translated_text, :review_date, :user_id, presence: true
  validates_with EqualValidator

  # validates :avatar, attachment_presence: true
  # validates_with AttachmentPresenceValidator, attributes: :avatar
  # validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes

end