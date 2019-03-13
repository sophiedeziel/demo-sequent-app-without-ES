class ApplicationProjector < Sequent::Projector
  def self.inherited(subclass)
    Sequent.configure do |config|
      config.event_handlers << subclass.new
    end
  end

  def ensure_valid!

  end
end
