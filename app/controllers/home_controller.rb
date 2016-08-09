class HomeController < ApplicationController
  before_action :require_login
  def index
    @card = if current_user.current_deck_id?
      Card.cards_for_learning_by_current_deck(current_user)
    else
      Card.cards_for_learning(current_user)
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

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

end
