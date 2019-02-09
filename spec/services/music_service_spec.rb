require 'rails_helper'
require 'base64'

RSpec.describe MusicService do
  describe '.encode_song' do
    let(:expected) { Base64.encode64('a song\n') }

    specify { expect(described_class.encode_song('a song\n')).to eq(expected) }
  end

  describe '.encode_songs' do
    let(:expected) do
      { 'spec/fixtures/test.txt': Base64.encode64(File.open('spec/fixtures/test.txt').read) }
    end

    specify do
      expect(described_class.encode_songs).to eq expected
    end
  end

  describe '.songs' do
    let(:expected) { [ { "spec/fixtures/test.txt": "some song\n" } ] }

    specify do
      expect(described_class.songs).to eq(expected)
    end
  end
end
