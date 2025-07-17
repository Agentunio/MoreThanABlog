class ContactMailer < ApplicationMailer
  default from: "kontakt@wpisyozyciu.pl"

  def form_contact
    @contact = params[:contact]
    mail(to: "wiadomosci@wpisyozyciu.pl", subject: "Wpisy o życiu - strona kontaktowa")
  end
end
