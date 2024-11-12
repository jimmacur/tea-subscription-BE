# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

tea_earl_grey = Tea.create(title: "Earl Grey", description: "A classic British black tea with bergamot.", temperature: 95, brew_time: 4)
tea_green = Tea.create(title: "Green Tea", description: "Light and refreshing green tea leaves.", temperature: 80, brew_time: 3)
tea_chamomile = Tea.create(title: "Chamomile", description: "A calming herbal tea made from chamomile flowers.", temperature: 100, brew_time: 5)
tea_peppermint = Tea.create(title: "Peppermint", description: "A refreshing mint tea perfect for digestion.", temperature: 100, brew_time: 5)
tea_jasmine = Tea.create(title: "Jasmine", description: "A fragrant green tea infused with jasmine blossoms.", temperature: 80, brew_time: 3)
tea_oolong = Tea.create(title: "Oolong", description: "A partially fermented tea with a complex flavor.", temperature: 90, brew_time: 4)

customer_1 = Customer.create(first_name: "Alice", last_name: "Johnson", email: "alice.johnson@example.com", address: "123 Elm St, Springfield")
customer_2 = Customer.create(first_name: "Bob", last_name: "Smith", email: "bob.smith@example.com", address: "456 Oak Ave, Riverside")
customer_3 = Customer.create(first_name: "Carol", last_name: "Williams", email: "carol.williams@example.com", address: "789 Pine Rd, Lakeview")
customer_4 = Customer.create(first_name: "Dave", last_name: "Brown", email: "dave.brown@example.com", address: "101 Maple Ln, Brookside")

subscription_1 = Subscription.create(title: "Monthly Earl Grey", price: 10.00, status: "active", frequency: "monthly", customer_id: customer_1.id)
subscription_1.teas << tea_earl_grey

subscription_2 = Subscription.create(title: "Variety Pack", price: 15.00, status: "active", frequency: "monthly", customer_id: customer_2.id)
subscription_2.teas << [tea_green, tea_chamomile, tea_peppermint]

subscription_3 = Subscription.create(title: "Herbal Collection", price: 12.00, status: "active", frequency: "monthly", customer_id: customer_3.id)
subscription_3.teas << [tea_chamomile, tea_peppermint, tea_jasmine]

subscription_4 = Subscription.create(title: "Oolong & Green Tea", price: 14.00, status: "active", frequency: "monthly", customer_id: customer_4.id)
subscription_4.teas << [tea_oolong, tea_green]