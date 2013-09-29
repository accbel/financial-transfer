FactoryGirl.define do
  factory :transfer do
    source_account "12345-6"
    destination_account "54321-0"
    amount 100.00
    due_date Date.today + 1.day
  end
end