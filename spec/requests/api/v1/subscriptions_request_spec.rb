require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  let(:customer) { create(:customer) }
  let(:subscription) { create(:subscription, customers: [customer]) }
  let(:tea) { create(:tea) }

  before do
    subscription.teas << tea
  end

  describe "GET /index" do
    it "returns all subscriptions" do
      create(:subscription, customers: [customer])
      create(:subscription, customers: [customer])
      
      get "/api/v1/subscriptions"
      
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      
      expect(json_response.size).to eq(Subscription.count)
      expect(json_response[0]['title']).to eq(subscription.title)
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
      
      customer_data = json_response["customer"]
      expect(customer_data["first_name"]).to eq(subscription.customers.first.first_name)
      expect(customer_data["last_name"]).to eq(subscription.customers.first.last_name)
      expect(customer_data["email"]).to eq(subscription.customers.first.email)
      expect(customer_data["address"]).to eq(subscription.customers.first.address)
      
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
      patch "/api/v1/subscriptions/#{subscription.id}", params: { subscription: { status: 'canceled' } }
      
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      
      expect(json_response["id"]).to eq(subscription.id)
      expect(json_response["status"]).to eq('canceled')
    end

    it 'changes the status of a subscription to active when updated successfully' do
      patch "/api/v1/subscriptions/#{subscription.id}", params:{ subscription: { status: 'active' } }
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response["id"]).to eq(subscription.id)
      expect(json_response["status"]).to eq('active')
    end

    it 'returns an unprocessable entity status when the subscription cannot be updated' do
      allow_any_instance_of(Subscription).to receive(:update).and_return(false)
      
      patch "/api/v1/subscriptions/#{subscription.id}", params: { subscription: { status: 'canceled' } }
      
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      
      expect(json_response["message"]).to eq("Failed to update subscription")
    end

    it 'changes the frequency of a subscription to biweekly when updated successfully' do
      patch "/api/v1/subscriptions/#{subscription.id}", params: { subscription: { frequency: 'biweekly' } }
      
      expect(response).to have_http_status(:ok)
  
      json_response = JSON.parse(response.body)
      
      expect(json_response["id"]).to eq(subscription.id)
      expect(json_response["frequency"]).to eq('biweekly')
    end
  end
end