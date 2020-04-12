class QuotesMailer < ApplicationMailer
    default from: "tecnihidraulicosjb@gmail.com"
    def quotes(name, recipient, subject, phone, message)
      @name = name
      @recipient = recipient
      @subject = subject
      @phone = phone
      @message = message

      mail(to:  recipient, :reply_to => "tecnihidraulicosjb@gmail.com", name:  "Nueva noticia", subject: recipient + " - " +  subject)
    end
end
