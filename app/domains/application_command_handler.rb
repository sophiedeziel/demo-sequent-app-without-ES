class ApplicationCommandHandler < Sequent::CommandHandler
  def self.inherited(subclass)
    Sequent.configure do |config|
      config.command_handlers << subclass.new
    end
  end
end
