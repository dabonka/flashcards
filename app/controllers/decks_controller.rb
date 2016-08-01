class DecksController < ApplicationController
  def index
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
    @deck = Deck.new(decks_params)
    @deck.save!
    redirect_to @deck
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

  private

  def decks_params
    params.require(:deck).permit(:title)
  end
end
