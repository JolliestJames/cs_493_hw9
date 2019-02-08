require 'rails_helper'

RSpec.describe AwsService::S3 do
  describe '.put_object' do
    let(:object) { 'song.mp3' }
    let(:path) { 'song.mp3' }

    it 'returns a Seahorse::Client::Response' do
      expect(described_class.put_object(object, path)).to be_a(Seahorse::Client::Response)
    end
  end

  describe '.objects' do
    specify { expect(described_class.objects).to be_a(Array) }
  end

  describe '.object' do
    let(:key) { 'Gemfile' }

    specify { expect(described_class.object(key)).to be_a(String) }
  end
end
