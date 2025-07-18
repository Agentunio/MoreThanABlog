class ContactController < ApplicationController
  def index
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.with(contact: @contact).form_contact.deliver_later
      redirect_to kontakt_path, notice: "Email wysłano poprawnie"
    else
      render :index, status: :unprocessable_entity
    end
  end


  private

  def contact_params
    params.permit(:name, :email, :subject, :message)
  end
end
