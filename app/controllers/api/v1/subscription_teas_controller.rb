class Api::V1::SubscriptionTeasController < ApplicationController
  before_action :find_subscription_and_tea
  
  def create
    if @subscription.teas.include?(@tea)
      render json: { message: 'Tea already added to subscription' }, status: :unprocessable_entity
    else
      @subscription.teas << @tea
      render_subscription(@subscription)
    end
  end

  def destroy
    if @subscription.teas.include?(@tea)
      @subscription.teas.delete(@tea)
      render_subscription(@subscription)
    else
      render json: { message: 'Tea not associated with this subscription' }, status: :unprocessable_entity
    end
  end
  

  private

  def find_subscription_and_tea
    @subscription = Subscription.find(params[:subscription_id])
    @tea = Tea.find(params[:id] || params[:tea_id])
  rescue ActiveRecord::RecordNotFound => e
    if e.model == Subscription
      render json: { message: 'Subscription not found' }, status: :not_found
    elsif e.model == Tea
      render json: { message: 'Tea not found' }, status: :not_found
    end
  end

  def render_subscription(subscription)
    render json: {
      id: subscription.id,
      title: subscription.title,
      price: subscription.price,
      status: subscription.status,
      frequency: subscription.frequency,
      customer: customer_details(subscription),
      teas: tea_details(subscription)
    }, status: :ok
  end

  def customer_details(subscription)
    customer = subscription.customers.first
    {
      first_name: customer.first_name,
      last_name: customer.last_name,
      email: customer.email,
      address: customer.address
    }
  end

  def tea_details(subscription)
    subscription.teas.map do |tea|
      { title: tea.title, description: tea.description, temperature: tea.temperature, brew_time: tea.brew_time }
    end
  end
end