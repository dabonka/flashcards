class Deck < ActiveRecord::Base
  belongs_to :user
  has_many   :card, dependent: :destroy
end
