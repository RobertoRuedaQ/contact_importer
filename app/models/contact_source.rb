class ContactSource < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :contacts
  has_one_attached :contact_list

  validates :contact_list_validation, presence: true

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


  def contact_list_validation
    if contact_list.attached?
      if !contact_list.blob.content_type == 'text/csv'
        contact_list.purge
        errors[:base] << 'Wrong format'
      end
    end
  end

end
