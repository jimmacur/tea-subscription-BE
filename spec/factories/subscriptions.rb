FactoryBot.define do
  factory :subscription do
    title { "Monthly Tea Subscription" }
    price { 15.0 }
    status { "active" }
    frequency { "monthly" }
    customer
  end
end