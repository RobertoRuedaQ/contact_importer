class ContactSource < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :contacts
  has_many :record_logs
  has_one_attached :contact_list

  aasm column: 'status' do 
    state :on_hold, initial: true
    state :processing
    state :failed
    state :finished
    
    event :process do
      transitions from: :on_hold, to: :processing
    end
  
    event :reject do
      transitions from: :processing, to: :failed
    end
  
    event :accept do
      transitions from: :processing, to: :finished
    end
  end


 

end
