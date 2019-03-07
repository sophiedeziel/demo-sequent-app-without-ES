module Account
  class CommandHandlers < Sequent::CommandHandler
    on Account::CreateAccount do |command|
      user = User.create(command.attributes.slice(:email, :fullname, :password, :aggregate_id))
      repository.create_event UserCreated, command.attributes.merge(user_id: user.id)
    end
  end
end

Sequent.configure do |config|
  config.command_handlers << Account::CommandHandlers.new
end
