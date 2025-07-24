class ContactsController < ApplicationController
  def show
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.with(contact: @contact).form_contact.deliver_later
      redirect_to contact_path, notice: "Email wysłano poprawnie"
    else
      render :index, status: :unprocessable_entity
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end
