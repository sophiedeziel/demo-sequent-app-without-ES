module Account
  class CreateAccount < Sequent::Command
    attrs email: String, fullname: String, password: Sequent::Secret
    validates_presence_of :email, :fullname, :password

    def initialize(args = {})
      super(args.merge(aggregate_id: Sequent.new_uuid))
    end
  end
end
