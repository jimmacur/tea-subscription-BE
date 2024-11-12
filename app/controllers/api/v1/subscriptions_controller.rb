class Api::V1::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.all
    render json: subscriptions.as_json(only: [:id, :title, :price, :status, :frequency, :customer_id])
  end

  def show
    subscription = find_subscription
    return if subscription.nil?

    render_subscription(subscription)
  end

  def update
    subscription = find_subscription
    
    if subscription.update(status: 'canceled')
      render_subscription(subscription, :ok)
    else  
      render json: {message: "Failed to update subscription" }, status: :unprocessable_entity
    end
  end

  private

  def render_subscription(subscription, status = :ok)
    render json: {
      id: subscription.id,
      title: subscription.title,
      price: subscription.price,
      status: subscription.status,
      frequency: subscription.frequency,
      customer: customer_details(subscription),
      teas: tea_details(subscription)
    }, status: status
  end

  def customer_details(subscription)
    {
      first_name: subscription.customer.first_name,
      last_name: subscription.customer.last_name,
      email: subscription.customer.email,
      address: subscription.customer.address
    }
  end

  def tea_details(subscription)
    subscription.teas.map do |tea|
      { title: tea.title, description: tea.description }
    end
  end

  def find_subscription
    Subscription.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Subscription not found' }, status: :not_found
    nil
  end
end

