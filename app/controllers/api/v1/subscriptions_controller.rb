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
    return if subscription.nil?

    if subscription_params.nil?
      render json: { message: 'Missing required parameters' }, status: :bad_request
    elsif subscription.update(subscription_params)
      render_subscription(subscription, :ok)
    else
      render json: { message: "Failed to update subscription", errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def subscription_params
    params.require(:subscription).permit(:status, :frequency)
  rescue ActionController::ParameterMissing
    nil
  end

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
    subscription.customers.map do |customer|
      {
        first_name: customer.first_name,
        last_name: customer.last_name,
        email: customer.email,
        address: customer.address
      }
    end
  end

  def tea_details(subscription)
    subscription.teas.map do |tea|
      { title: tea.title, description: tea.description, temperature: tea.temperature, brew_time: tea.brew_time }
    end
  end

  def find_subscription
    Subscription.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Subscription not found' }, status: :not_found
    nil
  end
end