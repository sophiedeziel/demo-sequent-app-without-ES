module BillingDomain
  class CommandHandlers < ApplicationCommandHandler
    on CreateBillingAccount do |command|
      attributes = { aggregate_id: command.aggregate_id, balance: 0, account_aggregate_id: command.account_aggregate_id }
      account = BillingDomain::Account.create!(attributes)
      repository.create_event BillingAccountCreated, account, attributes
    end

    on Prepay do |command|
      account = BillingDomain::Account.find_by!(aggregate_id: command.aggregate_id)

      Rails.logger.info "Getting payment of #{command.amount} from fictional payment source"
      repository.create_event PaymentCaptured, account, amount: command.amount

      attributes = { balance: account.balance + command.amount }
      account.update(attributes)
      repository.create_event BalanceUpdated, account, attributes
    end

    on PaybackBalance do |command|
      account = BillingDomain::Account.find_by!(aggregate_id: command.aggregate_id)
      balance = account.balance

      Rails.logger.info "Reimbursing #{balance}"
      repository.create_event ReimbursmentIssued, user, amount: balance

      attributes = { balance: account.balance - command.amount }
      account.update(attributes)
      repository.create_event BalanceUpdated, account, attributes
    end
  end
end
