class ContactsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @contacts = Contact.where(user_id: current_user.id)
  end
  
  def new
  end
  
  def create
  end


  private

  def contacts_params
    params.require(:contact).permit(:user_id, :contact_source_id, :name, :date_of_birth, :telephone, :address, :credit_card, :franchise, :email)
  end
end
