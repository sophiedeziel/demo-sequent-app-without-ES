module Account
  class CommandHandlers < Sequent::CommandHandler
    on CreateAccount do |command|
      user = User.create(command.attributes.slice(:email, :fullname, :password, :aggregate_id))
      repository.create_event Account::UserCreated, command.attributes.merge(user_id: user.id)
    end

    on SignIn do |command|
      user = User.find_by(aggregate_id: command.aggregate_id)
      repository.create_event Account::SignedIn, { user_id: user.id, aggregate_id: command.aggregate_id }
    end

    on Authenticate do |command|
      user = User.find_by!(command.attributes.slice(:email, :password))
      repository.create_event Account::SignedIn, { user_id: user.id, aggregate_id: command.aggregate_id }
    end
  end
end

Sequent.configure do |config|
  config.command_handlers << Account::CommandHandlers.new
end
