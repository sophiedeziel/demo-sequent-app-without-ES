module Account
  class SessionsWorkflow < Sequent::Workflow
    on SignedIn do |event|
      after_commit do
      end
    end
  end

  Sequent.configure do |config|
    config.event_handlers << SessionsWorkflow.new
  end
end
