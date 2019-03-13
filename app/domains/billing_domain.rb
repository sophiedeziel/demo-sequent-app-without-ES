module BillingDomain
  def self.table_name_prefix
    "billingdomain_"
  end
end

Dir[File.join(__dir__, 'billing', '*.rb')].each { |file| require file }
