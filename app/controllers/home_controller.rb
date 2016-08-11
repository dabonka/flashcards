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
    if @card.check_translation(params[:user_variant])
      @card.set_level_up(@card.level)
      @card.set_date(@card.level)
      flash[:card_true] = "Правильно"
    else

      if @card.fail_counter == 2 # Value of @card.fail_counter before thirds fail equal 2
        @card.set_level_down(@card.level)
      end

      @card.set_fail_counter(@card.fail_counter)

      flash[:card_false] = "Ошибка"
    end
      @card.save!
    redirect_to root_path

  end


end
