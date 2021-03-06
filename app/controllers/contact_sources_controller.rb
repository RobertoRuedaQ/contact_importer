class ContactSourcesController < ApplicationController
  include Sidekiq::Worker
  sidekiq_options retry: false

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
      file = @contact_source.contact_list.download 
      csv_table = CSV.new(file, :headers => true).read
      @csv_headers = csv_table.headers
    else
      redirect_to @contact_source, notice: "File not found, can't complete the process."
    end
  end

  def create_contacts_from_list
    @contact_source = ContactSource.find(params[:contact_source_id])
    @contact_source.process!
    headers_positions = params.to_unsafe_hash.invert
    headers_positions.select!{|k,v| ['name', 'date_of_birth', 'telephone', 'address', 'credit_card', 'email'].include?(k)}
    ContactImportWorker.perform_async(@contact_source.id, headers_positions)
    
    redirect_to @contact_source, notice: "The batch is currently being processed."
  end

  private

  def contact_source_params
    params.require(:contact_source).permit(:user_id, :contact_list)
  end


end
