class CreateContactService
  require 'csv'    

  def self.call(contact_source, header_positions)
    new(contact_source, header_positions).perform
  end

  def initialize(contact_source, header_positions)
    @contact_source = contact_source
    @header_position = header_positions
  end


  def perform
      file = @contact_source.contact_list.download
      csv = CSV.new(file, :headers => true).read
      csv.each do |row|
        contact = Contact.new(
          name: row[@header_position['name'].to_i],
          date_of_birth: row[@header_position['date_of_birth'].to_i],
          telephone: row[@header_position['telephone'].to_i],
          address: row[@header_position['address'].to_i],
          credit_card: row[@header_position['credit_card'].to_i],
          email: row[@header_position['email'].to_i],
          contact_source_id: @contact_source.id,
          user_id: @contact_source.user_id
        )
        if contact.save 
          puts 'record saved'
          @contact_source.check_status
        else
          RecordLog.create(contact_source_id: @contact_source.id, comments: "For the row that start with #{row[0]} was not possible to save the record because: #{contact.errors.messages.to_s}")
        end
      end
      @contact_source.check_status
  end
end
