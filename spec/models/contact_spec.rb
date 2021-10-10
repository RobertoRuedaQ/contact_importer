require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    subject { build(:contact) }

    it { should validate_presence_of(:name) } 
    it { should validate_presence_of(:date_of_birth)}
    it { should validate_presence_of(:telephone)}
    it { should validate_presence_of(:address)}
    it { should validate_presence_of(:credit_card)}
    it { should validate_presence_of(:email)}
  end
  
  it 'name can not contain special characters except minus' do
    user = create(:user)
    contact = build(:contact, name: 'test#$%', user_id: user.id)
    expect(contact.valid?).to eq(false)
    expect(contact.errors.messages[:name]).to eq(["not specials characters allowed for name"])
  end

  it 'email should have accepted format' do
    user = create(:user)
    contact = build(:contact, email: 'invalid email', user_id: user.id)
    
    expect(contact.valid?).to eq(false)
    expect(contact.errors.messages[:email]).to eq(["Email format not valid"])
  end

  it 'should be only one record per user' do
    user = create(:user)
    contact = create(:contact, email: 'test@email.com', user_id: user.id)
    second_contact = build(:contact, email: 'test@email.com', user_id: user.id)
    
    expect(second_contact.valid?).to eq(false)
    expect(second_contact.errors.messages[:email]).to eq(["contact already registered for this user"])
  end

  context 'testing credit card' do 
    
    it 'should save the franchaise' do
      user = create(:user)
      contact = create(:contact, credit_card: '5555555555554444',franchise: nil, user_id: user.id)

      expect(contact.franchise).to eq('MasterCard')
    end

    it 'identify visa franchise' do
      user = create(:user)
      contact = create(:contact, credit_card: '4111111111111111',franchise: nil, user_id: user.id)

      expect(contact.franchise).to eq('Visa')
    end

    it 'identify American Express franchise' do
      user = create(:user)
      contact = create(:contact, credit_card: '371449635398431',franchise: nil, user_id: user.id)

      expect(contact.franchise).to eq('American Express')
    end

    it 'identify Diners Club franchise' do
      user = create(:user)
      contact = create(:contact, credit_card: '30569309025904',franchise: nil, user_id: user.id)

      expect(contact.franchise).to eq('Diners Club')
    end

    it 'identify Discover franchise' do
      user = create(:user)
      contact = create(:contact, credit_card: '6011111111111117',franchise: nil, user_id: user.id)

      expect(contact.franchise).to eq('Discover')
    end

    it 'identify JCB' do
      user = create(:user)
      contact = create(:contact, credit_card: '3530111333300000',franchise: nil, user_id: user.id)

      expect(contact.franchise).to eq('JCB')
    end

  end


end
