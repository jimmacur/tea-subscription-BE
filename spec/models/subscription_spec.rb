require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :subscription_teas }
    it { should have_many(:teas).through(:subscription_teas) }
  end

  describe 'enums' do
    it 'defines status enum values' do
      expect(Subscription.statuses).to eq({ "active" => 0, "canceled" => 1 })
    end

    it 'defines frequency enum values' do
      expect(Subscription.frequencies).to eq({ "weekly" => 0, "biweekly" => 1, "monthly" => 2 })
    end

    it 'allows valid status values' do
      subscription = Subscription.new(status: "active")
      expect(subscription.status).to eq("active")
      subscription.status = "canceled"
      expect(subscription.status).to eq("canceled")
    end

    it 'allows setting valid frequency values' do
      subscription = Subscription.new(frequency: "weekly")
      expect(subscription.frequency).to eq("weekly")
      subscription.frequency = "monthly"
      expect(subscription.frequency).to eq("monthly")
    end

    it 'does not allow invalid status values' do
      expect { Subscription.new(status: "invalid_status") }.to raise_error(ArgumentError)
    end

    it 'does not allow invalid frequency values' do
      expect { Subscription.new(frequency: "invalid_frequency") }.to raise_error(ArgumentError)
    end
  end
end
