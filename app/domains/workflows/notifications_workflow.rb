class NotificationsWorkflow < ApplicationWorkflow
  on Billing::BalanceUpdated do |event|

    billing_account = Billing::Account.find_by!(aggregate_id: event.aggregate_id)
    user = Account::User.find_by!(aggregate_id: billing_account.account_aggregate_id)
    Notification.create(
      title: 'You have a new balance',
      content: "Check out your new balance on the Subscription page",
      user_id: user.id
    )
  end
end
