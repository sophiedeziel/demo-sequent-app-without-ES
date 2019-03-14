module Account
  class UserCreated < Sequent::Event
    attrs email: String, fullname: String, password: Sequent::Secret, user_id: Integer
  end

  class SignedIn < Sequent::Event
    attrs user_id: Integer, session_id: String
  end
end
