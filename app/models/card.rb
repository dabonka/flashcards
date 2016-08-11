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

  def set_review_date
    self.review_date = Date.current + 3.days
  end
  # scope :cards_for_learn, -> (u) { where("review_date <= ? AND user_id = ?", Time.now, u.id).limit(1).order("RANDOM()").take}
  # scope :cards_for_learn_by_current_deck, -> (u) { where("review_date <= ? AND user_id = ? AND deck_id = ?", Time.now, u.id, u.current_deck_id).limit(1).order("RANDOM()").take}

  scope :cards_for_learn, -> (u) { where("review_date <= ? AND user_id = ?", Time.now, u.id).limit(1).order("RANDOM()")}
  scope :cards_for_learn_by_current_deck, -> (u) { where("review_date <= ? AND user_id = ? AND deck_id = ?", Time.now, u.id, u.current_deck_id).limit(1).order("RANDOM()")}

  #  def self.cards_for_learn(u)
  #   where("user_id = ?", u.id).where("review_date <=?", Time.now ).limit(1).order("RANDOM()").take
  # end

  #  def self.cards_for_learn_by_current_deck(u)
  #   where("user_id = ?", u.id).where("review_date <=?", Time.now ).where("deck_id = ?", u.current_deck_id ).limit(1).order("RANDOM()").take
  # end

  def check_translation(mytext)
   self.translated_text.mb_chars.downcase.strip == mytext.mb_chars.downcase.strip
  end


  def set_date (level)
    case level
      when 0
        self.review_date = Time.current
      when 1
        self.review_date = Time.current + 12.hour
      when 2
        self.review_date = Time.current + 3.days
      when 3
        self.review_date = Time.current + 1.week
      when 4
        self.review_date = Time.current + 2.weeks
      else
        self.review_date = Time.current + 1.month
    end
  end

  def set_level_up(level)
    self.level +=1 if level < 5 # Level 5 the highest possible cards level
  end

  def set_level_down(level)
    case level # We reduce the level of card of but not less than 0
      when 1
        self.level = 0
      when 2
        self.level = 0
      when 3
        self.level = 1
      when 4
        self.level = 2
      when 5
        self.level = 3
      else
    end
  end

  def set_fail_counter(fail_counter)
    self.fail_counter +=1

    if self.fail_counter >= 3
      self.fail_counter = 0

      # if self.level == 1 || self.level == 2
      # if true
      #   self.level = 0
      #  else
      #    self.level -= 2
      #  end

    end

  end




  validates :original_text, :translated_text, :review_date, :user_id, presence: true
  validates_with EqualValidator

  # validates :avatar, attachment_presence: true
  # validates_with AttachmentPresenceValidator, attributes: :avatar
  # validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
  
end