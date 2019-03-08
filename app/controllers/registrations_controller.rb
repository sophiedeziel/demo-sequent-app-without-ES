class RegistrationsController < ApplicationController
  def new
    @command = Account::CreateAccount.new
  end

  def create
    @command = Account::CreateAccount.new(permitted_params)
    Sequent.command_service.execute_commands @command, Account::SignIn.new(aggregate_id: @command.aggregate_id)
    @user = User.find_by(aggregate_id: @command.aggregate_id)
    session[:user_session] = @user.session
    redirect_to new_subscription_path
  end

  private

  def permitted_params
    params.require(:registration).permit(:email, :fullname, :password)
  end
end
