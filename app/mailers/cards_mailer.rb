class CardsMailer < ApplicationMailer
  def pending_cards_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Reminder Cards')
    @card
  end
end
