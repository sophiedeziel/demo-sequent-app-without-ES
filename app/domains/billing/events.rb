module Billing
  class BillingAccountCreated < Sequent::Event
    attrs balance: BigDecimal, account_aggregate_id: String
  end

  class PaymentCaptured < Sequent::Event
    attrs balance: BigDecimal
  end

  class PaymentCaptured < Sequent::Event
    attrs amount: BigDecimal
  end

  class BalanceUpdated < Sequent::Event
    attrs balance: BigDecimal
  end

  class ReimbursmentIssued < Sequent::Event
    attrs amount: BigDecimal
  end
end
