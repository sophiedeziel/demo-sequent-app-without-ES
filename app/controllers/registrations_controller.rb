class RegistrationsController < ApplicationController
  def new
    @command = AccountDomain::CreateAccount.new
  end

  def create
    @command = AccountDomain::CreateAccount.new(permitted_params)
    Sequent.command_service.execute_commands @command, AccountDomain::SignIn.new(aggregate_id: @command.aggregate_id)
    @user = AccountDomain::User.find_by(aggregate_id: @command.aggregate_id)
    session[:user_session] = @user.session
    redirect_to new_subscription_path
  end

  private

  def permitted_params
    params.require(:registration).permit(:email, :fullname, :password)
  end
end
