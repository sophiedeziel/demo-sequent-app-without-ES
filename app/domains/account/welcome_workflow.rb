module Account
  class WelcomeWorkflow < Sequent::Workflow
    on UserCreated do |event|
      after_commit do
        Rails.logger.info "Sending email to #{event.email}"
        #SendEmailJob.perform_async(event)
      end
    end
  end

  Sequent.configure do |config|
    config.event_handlers << WelcomeWorkflow.new
  end
end
