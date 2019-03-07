module Account
  class UserCreated < Sequent::Event
    attrs email: String, fullname: String, password: Sequent::Secret, user_id: Integer
  end
end
