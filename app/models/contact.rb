class Contact < ApplicationRecord

  belongs_to :user
  
  validates :name, :telephone, :address, :date_of_birth, :credit_card, :email, presence: true
  validates :telephone, format:{
    with: /\A\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2}\z/
  }
  validates :telephone, format:{
    with: /\A\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2}\z/
  }
  validates :name, format: { with: /\A[a-zA-Z\-]+\z/, message:'not specials characters allowed for name'}
  validates :email,format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'Email format not valid'}
  validates :email, uniqueness: { scope: :user_id, message: 'contact already registered for this user'} 
  validates_date :date_of_birth, format: 'yyyy-mm-dd'

  before_create :set_franchise
  before_create :save_last_four


  def set_franchise
    four_digits = self.credit_card.chars.first(4).join

    case four_digits
    when  /^4[0-9]{0,}$/
      self.franchise = 'Visa'
    when  /^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)[0-9]{0,}$/
      self.franchise = 'MasterCard'
    when  /^3[47][0-9]{0,}$/
      self.franchise = 'American Express'
    when  /^3(?:0[0-59]{1}|[689])[0-9]{0,}$/
      self.franchise = 'Diners Club'
    when  /^(6011|65|64[4-9]|62212[6-9]|6221[3-9]|622[2-8]|6229[01]|62292[0-5])[0-9]{0,}$/
      self.franchise = 'Discover'
    when  /^(?:2131|1800|35)[0-9]{0,}$/
      self.franchise = 'JCB'
    else
      self.franchise = nil
    end
  end

  def save_last_four
    self.last_four = self.credit_card.last(4)
  end

end
