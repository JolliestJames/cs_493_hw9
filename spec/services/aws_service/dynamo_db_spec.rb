require 'rails_helper'

RSpec.describe AwsService::DynamoDB do
  describe '.client' do
    specify { expect(described_class.client).to be_a(Aws::DynamoDB::Client) }
  end

  describe '.scan' do
  end

  describe '.query' do
  end
end
