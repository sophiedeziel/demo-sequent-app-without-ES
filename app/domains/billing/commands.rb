module Billing
  class CreateBillingAccount < Sequent::Command
    attrs account_aggregate_id: String
    def initialize(args = {})
      super(args.merge(aggregate_id: Sequent.new_uuid))
    end
  end

  class Prepay < Sequent::Command
    attrs amount: BigDecimal
  end

  class PaybackBalance < Sequent::Command
  end
end
