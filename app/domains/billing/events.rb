module Billing
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
