require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  let(:customer) { create(:customer) }
  let(:subscription) { create(:subscription, customer: customer) }
  let(:tea) { create(:tea) }

  before do
    subscription.teas << tea
  end

  describe "GET /index" do
    it "returns all subscriptions" do
      get "/api/v1/subscriptions"
      
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      
      expect(json_response.size).to eq(Subscription.count)
    end
  end

  describe "GET /show" do
    it "returns a subscription" do
      get "/api/v1/subscriptions/#{subscription.id}"
      
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      
      expect(json_response["id"]).to eq(subscription.id)
      expect(json_response["title"]).to eq(subscription.title)
      expect(json_response["price"].to_f).to eq(subscription.price.to_f)
      expect(json_response["status"]).to eq(subscription.status)
      expect(json_response["frequency"]).to eq(subscription.frequency)
      expect(json_response["customer"]["first_name"]).to eq(subscription.customer.first_name)
      expect(json_response["customer"]["last_name"]).to eq(subscription.customer.last_name)
      expect(json_response["customer"]["email"]).to eq(subscription.customer.email)
      expect(json_response["customer"]["address"]).to eq(subscription.customer.address)
      expect(json_response["teas"].size).to eq(subscription.teas.size)
    end

    it "returns a not found message when a subscription doesn't exist" do
      get "/api/v1/subscriptions/9999"
      
      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      
      expect(json_response["message"]).to eq("Subscription not found")
    end
  end

  describe "PATCH /update" do
    it 'changes the status of a subscription to canceled when updated successfully' do
      patch "/api/v1/subscriptions/#{subscription.id}", params: { status: 'canceled' }
      
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      
      expect(json_response["id"]).to eq(subscription.id)
      expect(json_response["status"]).to eq('canceled')
    end

    it 'returns an unprocessable entity status when the subscription cannot be updated' do
      allow_any_instance_of(Subscription).to receive(:update).and_return(false)
      
      patch "/api/v1/subscriptions/#{subscription.id}", params: { status: 'canceled' }
      
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      
      expect(json_response["message"]).to eq("Failed to update subscription")
    end
  end
end