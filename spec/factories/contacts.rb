FactoryBot.define do
  factory :contact do
    name {'user-test123'}
    date_of_birth {32.years.ago}
    telephone {'(+57) 320 432 05 09'}
    address {'calle 10 # 20-30'}
    credit_card {'5555555555554444'}
    franchise {'MaterCard'}
    email {'test@email.com'}
  end
end
