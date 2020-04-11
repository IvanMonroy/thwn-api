class SubscriptionMailer < ApplicationMailer
  default from: "tecnihidraulicosjb@gmail.com"
  def subscription(name, recipient)
    @name = name
    @recipient = recipient

    mail(to:  recipient, :reply_to => "tecnihidraulicosjb@gmail.com", name:  "Nueva noticia", subject:  "Hola " + name + ", gracias por suscribirte!")
  end


end
