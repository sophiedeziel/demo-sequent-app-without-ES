class SubscriptionsController < ApplicationController

  def new
  end

  def create
    @command = Subscription::SubscribeToPlan.new(permitted_params.merge(user_id: current_user.id))
    Sequent.command_service.execute_commands @command
    redirect_to subscription_path
  end

  def show
    @events = Sequent::Core::EventRecord.where(aggregate_id: current_user.aggregate_id, event_type: ['Subscription::SubscriptionCreated', 'Billing::PaymentCaptured', 'Subscription::SubscriptionCancelled', 'Billing::ReimbursmentIssued']).order(created_at: :desc)
  end

  def destroy
    @command = Subscription::CancelSubscription.new(user_id: current_user.id, aggregate_id: current_user.aggregate_id)
    Sequent.command_service.execute_commands @command
    redirect_to subscription_path
  end

  private


  def permitted_params
    params.require(:subscription).permit(:plan_id, :aggregate_id)
  end
end
