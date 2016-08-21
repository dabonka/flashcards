class CardsController < ApplicationController
  before_action :require_login
  def index
    @cards = current_user.cards
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = current_user.cards.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def create
    @card = current_user.cards.create(cards_params)
    if @card.save!
      redirect_to cards_path
    else
      render :new
    end
  end

  def update
    @card = Card.find(params[:id])
      if @card.update(cards_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = I18n.t("card.error")
      redirect_to login_path
    end
  end

  #def require_login
    #redirect_to new_user_path unless current_user
  #end

  def cards_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :avatar, :deck_id, :level, :fail_counter)
  end

end
