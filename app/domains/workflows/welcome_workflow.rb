class WelcomeWorkflow < ApplicationWorkflow
  on AccountDomain::UserCreated do |event|
    after_commit do
      Rails.logger.info "Sending email to #{event.email}"
      #SendEmailJob.perform_async(event)
    end
  end
end

