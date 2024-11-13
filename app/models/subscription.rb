class Subscription < ApplicationRecord
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas
  has_many :subscription_customers
  has_many :customers, through: :subscription_customers

  enum status: { active: 0, canceled: 1 }
  enum frequency: { weekly: 7, biweekly: 14, monthly: 30 }
end
