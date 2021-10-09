require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do 
    user = create(:user)
    contact = create(:contact, user_id: user.id)

    it { should validate_presence_of(:name) } 
    it { should validate_presence_of(:date_of_birth)}
    it { should validate_presence_of(:phone)}
    it { should validate_presence_of(:address)}
    it { should validate_presence_of(:credit_card)}
    it { should validate_presence_of(:franchise)}
    it { should validate_presence_of(:email)}
  
    it 'name can not contain special characters except minus' do
        expect(contact.name).not_to include(//)
    end
  end

  describe 'associations' do
    it { should belong_to(:user)}
  end
end
