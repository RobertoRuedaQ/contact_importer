require 'rails_helper'

RSpec.describe RecordLog, type: :model do
  describe 'validations' do
    subject { build(:record_log) }

    it { should validate_presence_of(:comments) } 
  end
end
