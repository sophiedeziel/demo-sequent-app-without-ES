module Account
  class CommandHandlers < ApplicationCommandHandler
    on CreateAccount do |command|
      user = User.create!(command.attributes.slice(:email, :fullname, :password, :aggregate_id))
      repository.create_event UserCreated, user, command.attributes.merge(user_id: user.id)
    end

    on SignIn do |command|
      user = User.find_by(aggregate_id: command.aggregate_id)
      user.update(session: Sequent.new_uuid)
      repository.create_event SignedIn, user, { user_id: user.id, session_id: user.session }
    end

    on Authenticate do |command|
      user = User.find_by!(command.attributes.slice(:email, :password))
      repository.create_event SignedIn, user, { user_id: user.id }
    end
  end
end

