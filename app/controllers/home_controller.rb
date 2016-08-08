class HomeController < ApplicationController
  def index
     if current_user != nil
       @card = current_user.cards.first
     end
   end

  def compare
    @card = Card.find(params[:card_id])
    if @card.check_translation(params[:user_variant])
      @card.set_review_date
      @card.save!
      flash[:card_true] = "Правильно"
    else
      flash[:card_false] = "Ошибка"
    end
   redirect_to root_path
  end
end
