module Billing
  class Prepay < Sequent::Command
    attrs amount: BigDecimal
  end

  class PaybackBalance < Sequent::Command
  end
end
