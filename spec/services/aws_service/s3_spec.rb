require 'rails_helper'

RSpec.describe AwsService::S3 do
  describe '.put_object' do
    let(:object) { 'spec/fixtures/test.txt' }
    let(:path) { 'spec/fixtures/test.txt' }

    it 'returns a Seahorse::Client::Response' do
      expect(described_class.put_object(object, path)).to be_a(Seahorse::Client::Response)
    end
  end

  describe '.objects' do
    specify { expect(described_class.objects).to be_a(Array) }
  end

  describe '.object' do
    let(:key) { 'spec/fixtures/test.txt' }

    specify { expect(described_class.object(key)).to be_a(Seahorse::Client::Response) }
  end
end
