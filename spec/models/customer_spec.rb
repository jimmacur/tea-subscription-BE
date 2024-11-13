require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :subscription_customers }
    it { should have_many(:subscriptions).through(:subscription_customers) }
  end
end
