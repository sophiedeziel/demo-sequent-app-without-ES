class SubscriptionsController < ApplicationController

  def new
  end

  def create
    @command = SubscriptionDomain::SubscribeToPlan.new(permitted_params.merge(user_id: current_user.id, account_aggregate_id: current_user.aggregate_id))
    Sequent.command_service.execute_commands @command
    redirect_to subscription_path
  end

  def show
    @subscription = Subscription.find_by(user: current_user)
    @events = Sequent::Core::EventRecord.where(aggregate_id: current_user.aggregate_id, event_type: ['Subscription::SubscriptionCreated', 'Billing::PaymentCaptured', 'Subscription::SubscriptionCancelled', 'Billing::ReimbursmentIssued']).order(created_at: :desc)
  end

  def destroy
    @command = SubscriptionDomain::CancelSubscription.new(user_id: current_user.id, aggregate_id: current_user.aggregate_id)
    Sequent.command_service.execute_commands @command
    redirect_to subscription_path
  end

  private


  def permitted_params
    params.require(:subscription).permit(:plan_id, :aggregate_id)
  end
end
