class ContactImportWorker
  include Sidekiq::Worker

  def perform(contact_source_id, header_positions)
    contact_source = ContactSource.find(contact_source_id)
    CreateContactService.call(contact_source, header_positions)
  end
end
