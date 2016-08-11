# RSpec.configure do |config|
  # config.include FactoryGirl::Syntax::Methods
# end

FactoryGirl.define do
  factory :card do
    original_text "Word"
    translated_text "Slovo"
    review_date Date.current
    level 0
    fail_counter 0
    # avatar_content_type "image/jpeg"
    # avatar_file_name "Sky.jpg"
    # avatar_file_size 62293
    association :user, factory: :user
    #  id 1000
  end
end