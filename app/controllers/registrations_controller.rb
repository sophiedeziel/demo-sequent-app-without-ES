class RegistrationsController < ApplicationController
  def new
    @command = Account::CreateAccount.new
  end

  def create
    @command = Account::CreateAccount.new(permitted_params)
    Sequent.command_service.execute_commands @command, Account::SignIn.new(aggregate_id: @command.aggregate_id)
    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:registration).permit(:email, :fullname, :password)
  end
end
