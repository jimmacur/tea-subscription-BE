# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

customer1 = Customer.create(first_name: "Alice", last_name: "Smith", email: "alice@example.com", address: "123 Elm St")
customer2 = Customer.create(first_name: "Bob", last_name: "Johnson", email: "bob@example.com", address: "456 Oak St")
customer3 = Customer.create(first_name: "Charlie", last_name: "Brown", email: "charlie@example.com", address: "789 Pine St")
customer4 = Customer.create(first_name: "Diana", last_name: "White", email: "diana@example.com", address: "101 Maple St")

tea1 = Tea.create(title: "Earl Grey", description: "A classic British black tea with bergamot.", temperature: 95, brew_time: 4)
tea2 = Tea.create(title: "Green Tea", description: "Light and refreshing green tea leaves.", temperature: 80, brew_time: 3)
tea3 = Tea.create(title: "Chamomile", description: "A calming herbal tea made from chamomile flowers.", temperature: 100, brew_time: 5)
tea4 = Tea.create(title: "Peppermint", description: "A refreshing mint tea perfect for digestion.", temperature: 100, brew_time: 5)
tea5 = Tea.create(title: "Jasmine", description: "A fragrant green tea infused with jasmine blossoms.", temperature: 80, brew_time: 3)
tea6 = Tea.create(title: "Oolong", description: "A partially fermented tea with a complex flavor.", temperature: 90, brew_time: 4)

subscription1 = Subscription.create(title: "Monthly Tea Subscription", price: 15.99, frequency: 30)
subscription2 = Subscription.create(title: "Biweekly Tea Subscription", price: 9.99, frequency: 14)
subscription3 = Subscription.create(title: "Weekly Tea Subscription", price: 5.99, frequency: 7)

subscription1.customers << customer1
subscription1.customers << customer2
subscription2.customers << customer3
subscription2.customers << customer4
subscription3.customers << customer1
subscription3.customers << customer3

subscription1.teas << tea1
subscription1.teas << tea2
subscription2.teas << tea3
subscription2.teas << tea4
subscription3.teas << tea5
subscription3.teas << tea6

puts "Seed data created successfully!"