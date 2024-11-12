FactoryBot.define do
  factory :customer do
    first_name { "John" }
    last_name  { "Doe" }
    email      { "john.doe@example.com" }
    address    { "123 Elm St" }
  end
end