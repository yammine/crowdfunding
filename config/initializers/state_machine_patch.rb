require 'state_machine/version'

unless StateMachine::VERSION == '1.2.0'

  Rails.logger.warn "Remove me, StateMachine version has changed."
end

module StateMachine::Integrations::ActiveModel
  public :around_validation
end