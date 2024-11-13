require 'rails_helper'

RSpec.describe "SubscriptionTeas", type: :request do
  describe "POST /api/v1/subscriptions/:subscription_id/subscription_teas" do
    let(:subscription) { create(:subscription) }
    let(:new_tea) { create(:tea) }

    it 'adds a tea to the subscription' do
      post "/api/v1/subscriptions/#{subscription.id}/subscription_teas", params: { tea_id: new_tea.id }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      tea_titles = json_response["teas"].map { |tea| tea["title"] }

      expect(tea_titles).to include(new_tea.title)
    end

    it 'returns an error if the tea is already associated with the subscription' do
      subscription.teas << new_tea
      post "/api/v1/subscriptions/#{subscription.id}/subscription_teas", params: { tea_id: new_tea.id }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)

      expect(json_response["message"]).to eq("Tea already added to subscription")
    end
  end

  describe "DELETE /api/v1/subscriptions/:subscription_id/subscription_teas/:id" do
    let(:subscription) { create(:subscription) }
    let(:new_tea) { create(:tea) }
    let!(:existing_tea) { create(:tea) }

    before do
      subscription.teas << existing_tea
    end

    it 'removes a tea from the subscription' do
      delete "/api/v1/subscriptions/#{subscription.id}/subscription_teas/#{existing_tea.id}"

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      tea_titles = json_response["teas"].map { |tea| tea["title"] }

      expect(tea_titles).not_to include(existing_tea.title)
    end

    it 'returns an error if the tea is not associated with the subscription' do
      non_associated_tea = create(:tea)
      delete "/api/v1/subscriptions/#{subscription.id}/subscription_teas/#{non_associated_tea.id}"

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)

      expect(json_response["message"]).to eq("Tea not associated with this subscription")
    end
  end
end