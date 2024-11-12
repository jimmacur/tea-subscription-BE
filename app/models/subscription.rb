class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  enum status: { active: 0, canceled: 1 }
  enum frequency: { weekly: 0, biweekly: 1, monthly: 2 }
end
