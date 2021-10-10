class ContactSourcesController < ApplicationController
  require 'csv'    

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
        format.html { redirect_to contact_source_match_headers_path(@contact_source), notice: "Batch was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @contact_source = ContactSource.find(params[:id])
  end

  def destroy
    @contact_source.destroy
    respond_to do |format|
      format.html { redirect_to contact_sources_path, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def match_headers
    @contact_source = ContactSource.find(params[:contact_source_id])
    if @contact_source.contact_list.attached?
      csv_url = public_contact_list_url(@contact_source)
      @csv_table = CSV.open(csv_url, :headers => true).read
    else
      redirect_to @contact_source, notice: "File not found, can't complete the process."
    end
  end

  private

  def contact_source_params
    params.require(:contact_source).permit(:user_id, :contact_list)
  end


  def public_contact_list_url(contact_source)
    if contact_source.contact_list&.attachment
      if Rails.env.development?
          url = Rails.application.routes.url_helpers.rails_blob_url(contact_source.contact_list, only_path: true)
      else
          url = contact_source.contact_list&.service_url&.split("?")&.first
      end
      return url
    end
  end

end
