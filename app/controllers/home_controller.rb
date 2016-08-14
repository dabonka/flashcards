class HomeController < ApplicationController
  before_action :require_login
  def index
    @card = if current_user.current_deck_id?
      Card.cards_for_learn(current_user).take
    else
      Card.cards_for_learn_by_current_deck(current_user).take
    end
  end

  def compare
    @card = Card.find(params[:card_id])
    if @card.check_translation(params[:user_variant])[:translate_ok]
      @card.success
      flash[:card_true] = @card.check_translation(params[:user_variant])[:user_version]
    elsif @card.check_translation(params[:user_variant])[:misprint_ok]
    @card.success
      flash[:card_misprint] = @card.check_translation(params[:user_variant])[:user_version]
    elsif @card.check_translation(params[:user_variant])[:translate_false]
      @card.failed
      flash[:card_false] = @card.check_translation(params[:user_variant])[:user_version]
    end
    redirect_to root_path
  end
end
