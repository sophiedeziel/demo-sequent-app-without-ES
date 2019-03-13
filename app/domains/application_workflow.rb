class ApplicationWorkflow < Sequent::Workflow
  def self.inherited(subclass)
    Sequent.configure do |config|
      config.event_handlers << subclass.new
    end
  end
end
