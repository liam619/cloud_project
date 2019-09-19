class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      MyMailer.contact_us(@contact).deliver_now
      flash[:success] = "Your inquiries/feedback have been sent to the site of admin. Thank you."
      redirect_back(fallback_location: root_path)
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end