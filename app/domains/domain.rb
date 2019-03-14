module Domain
  module ClassMethods
    def table_name_prefix
      self.to_s.downcase + '_'
    end
  end

  def self.included(base)
    base.extend ClassMethods

    Dir[File.join(__dir__, base.to_s.downcase, '*.rb')].each { |file| require file }
  end
end
