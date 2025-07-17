class ContactController < ApplicationController
  def index
  end
  def create
    @contact = contact_params
    if ContactMailer.with(contact: @contact).form_contact.deliver_later
      redirect_to kontakt_path, notice: "Email wysłano poprawnie"
    end
  end


  private

  def contact_params
    params.permit(:name, :email, :subject, :message)
  end
end
