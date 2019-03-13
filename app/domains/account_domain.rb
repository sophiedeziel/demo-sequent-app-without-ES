module AccountDomain
end

Dir[File.join(__dir__, 'account', '*.rb')].each { |file| require file }
