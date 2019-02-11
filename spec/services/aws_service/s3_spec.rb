require 'rails_helper'

RSpec.describe AwsService::S3 do
  describe '.client' do
    specify { expect(described_class.client).to be_a(Aws::S3::Client) }
  end

  describe '.put_object' do
    let(:object) { 'song.mp3' }
    let(:path) { 'artic_monkeys/am/do_i_wanna_know?' }

    it 'returns a Seahorse::Client::Response' do
      expect(described_class.put_object(object, path)).to be_a(Seahorse::Client::Response)
    end
  end

  describe '.objects' do
    specify { expect(described_class.objects).to be_a(Array) }
  end

  describe '.object' do
    let(:key) { 'artic_monkeys/am/do_i_wanna_know?' }

    specify { expect(described_class.object(key)).to be_a(Seahorse::Client::Response) }
  end

  describe '.object_url' do
    let(:key) { 'artic_monkeys/am/do_i_wanna_know?' }

    specify { expect(described_class.object_url(key)).to be_a(String) }
  end
end
