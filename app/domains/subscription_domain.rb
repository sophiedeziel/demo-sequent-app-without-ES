module SubscriptionDomain
  def self.table_name_prefix
    "subscriptiondomain_"
  end
end

Dir[File.join(__dir__, 'subscription', '*.rb')].each { |file| require file }
