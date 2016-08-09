class DecksController < ApplicationController
  before_action :require_login
  def index
    @deck = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @deck = Deck.new
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = current_user.decks.new(decks_params)
    if @deck.save!
      redirect_to decks_path
    else
      render :new
    end
  end


  def update
    @deck = Deck.find(params[:id])
    if @deck.update(decks_params)
      redirect_to @deck
    else
      render 'edit'
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  def set_current
    current_user.update(current_deck_id: params[:id])
    redirect_to decks_path
  end

  private

  def decks_params
    params.require(:deck).permit(:title, :user_id)
  end
end
