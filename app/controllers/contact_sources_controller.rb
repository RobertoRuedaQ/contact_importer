class ContactSourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @contact_sources = ContactSource.where(user_id: current_user.id)
  end

  def new
    @contact_source = ContactSource.new
  end

  def create
    @contact_source = ContactSource.new(contact_source_params)
    respond_to do |format|
      if @contact_source.save
        format.html { redirect_to @contact, notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @contact_source.destroy
    respond_to do |format|
      format.html { redirect_to contact_sources_path, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def contact_source_params
    params.require(:contact_source).permit(:id, :user_id, :status, :contact_list)
  end
end
