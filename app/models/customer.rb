class Customer < ApplicationRecord
  has_many :subscription_customers
  has_many :subscriptions, through: :subscription_customers
end
