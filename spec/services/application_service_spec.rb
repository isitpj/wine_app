require 'rails_helper'

RSpec.describe ApplicationService do
  describe '.call' do
    it 'calls an instance of itself' do
      expect_any_instance_of(ApplicationService).to receive(:call)

      ApplicationService.call
    end
  end
end
