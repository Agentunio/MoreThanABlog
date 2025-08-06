module Api
  class ContactsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        ContactMailer.with(contact: @contact).form_contact.deliver_later
        render json: { message: "Email wysłano" }, status: :created
      else
        render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
      end
    end


    private

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message)
    end
  end
end
