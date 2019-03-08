module Billing
  class CommandHandlers < Sequent::CommandHandler
    on Prepay do |command|
      user = User.find_by(aggregate_id: command.aggregate_id)

      Rails.logger.info "Getting payment of #{command.amount} from fictional payment source"
      repository.create_event Billing::PaymentCaptured, user, amount: command.amount

      attributes = { balance: command.amount }
      user.update(attributes)
      repository.create_event Billing::BalanceUpdated, user, attributes
    end

    on PaybackBalance do |command|
      user = User.find_by(aggregate_id: command.aggregate_id)
      balance = user.balance

      Rails.logger.info "Reimbursing #{balance}"
      repository.create_event Billing::ReimbursmentIssued, user, amount: balance

      attributes = { balance: 0 }
      user.update(attributes)
      repository.create_event Billing::BalanceUpdated, user, attributes
    end
  end

  Sequent.configure do |config|
    config.command_handlers << Billing::CommandHandlers.new
  end
end


