FactoryBot.define do
  factory :subscription do
    title { "Monthly Tea Subscription" }
    price { 15.00 }
    status { "active" }
    frequency { "monthly" }
    customers { [FactoryBot.create(:customer)] }
  end
end