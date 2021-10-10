FactoryBot.define do
  factory :contact do
    name {'roberto'}
    date_of_birth {'1989/11/08'}
    telephone {'(+57) 320 432 05 09'}
    address {'calle 10 # 20-30'}
    credit_card {'5555555555554444'}
    email {'test@email.com'}
    franchise {'MasterCard'}
  end
end
