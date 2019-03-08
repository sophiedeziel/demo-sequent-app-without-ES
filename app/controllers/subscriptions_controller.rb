class SubscriptionsController < ApplicationController
  helper_method :current_user

  def new
  end

  def create
    @command = Subscription::SubscribeToPlan.new(permitted_params.merge(user_id: current_user.id))
    Sequent.command_service.execute_commands @command
    redirect_to subscription_path
  end

  def show
    @events = Sequent::Core::EventRecord.where(aggregate_id: current_user.aggregate_id, event_type: ['Subscription::SubscriptionCreated', 'Billing::PaymentCaptured']).order(created_at: :desc)
  end

  private

  def current_user
    @current_user ||= User.find_by(session: session[:user_session])
  end

  def permitted_params
    params.require(:subscription).permit(:plan_id, :aggregate_id)
  end
end
