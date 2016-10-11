class Api::V1::CardsController < ApplicationController
  # before_action :require_login
  respond_to :json
  def index
    @card = Card.all_cards_for_learn.take
  end

  def compare
    @card = Card.find(params[:card_id])
    result = @card.check_translation(params[:user_variant])
    if result[:translate_ok]
    #  @card.success
      myhash = Supermemo.success_efactor(@card.counter, @card.efactor)
      flash[:card_true] = result[:message]
    elsif result[:misprint_ok]
    # @card.success
      myhash = Supermemo.misprint_efactor(@card.counter, @card.efactor)
     flash[:card_misprint] = result[:message]
    elsif result[:translate_false]
      # @card.failed
      myhash = Supermemo.failed_efactor(@card.counter, @card.efactor)
      flash[:card_false] = result[:message]
    end
    @card.update_attributes(myhash)
    @card.save
    redirect_to root_path
  end

   def give_me_json 
    @card = Card.find(params[:card_id]) 
    respond_with :card_id, :original_text, :translated_text, @card 
   end