require 'rails_helper'

RSpec.describe AwsService::Credentials do
  describe '.simple_storage_service' do
    subject { described_class.simple_storage_service }

    it { should be_an_instance_of(Aws::AssumeRoleCredentials) }
  end
end
