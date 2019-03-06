require 'rails_helper'
require 'base64'

RSpec.describe MusicService::V2 do
  describe '.genres' do
    let(:result) do
      [
        { "genre" => "genre_1" },
        { "genre" => "genre_2" },
        { "genre" => "genre_2" },
        { "genre" => "genre_2" },
        { "genre" => "genre_3" },
      ]
    end
    let(:expected) { ['genre_1', 'genre_2', 'genre_3'] }

    before do
      allow(AwsService::DynamoDB).to receive(:scan).and_return(result)
    end

    it 'returns a list of genres' do
      expect(described_class.genres).to eq(expected)
    end
  end

  describe '.genre' do
    let(:result) do
      [
        { 'artist' => 'manchester orchestra' },
        { 'artist' => 'manchester orchestra' },
        { 'artist' => 'manchester orchestra' },
        { 'artist' => 'punch brothers' },
        { 'artist' => 'punch brothers' },
        { 'artist' => 'punch brothers' },
      ]
    end
    let(:expected) { ['manchester orchestra', 'punch brothers'] }

    before do
      allow(AwsService::DynamoDB).to receive(:scan).and_return(['genre'])
      allow(AwsService::DynamoDB)
        .to receive(:query)
        .and_return(result)
    end

    it 'returns a list of artists' do
      expect(described_class.genre('genre')).to eq(expected)
    end
  end

  describe '.artist' do
    let(:result) do
      [
        { 'album' => 'simple math' },
        { 'album' => 'mean everything to nothing' },
        { 'album' => 'a black mile to the surface' },
        { 'album' => 'simple math' },
        { 'album' => 'cope' },
        { 'album' => 'cope' }
      ]
    end
    let(:expected) do
      [
        'simple math',
        'mean everything to nothing',
        'a black mile to the surface',
        'cope'
      ]
    end

    before do
      allow(described_class).to receive(:genres).and_return(Array.new(2))
      allow(AwsService::DynamoDB)
        .to receive(:query)
        .exactly(2).times
        .and_return(result)
    end

    specify { expect(described_class.artist('artist')).to eq(expected) }
  end

  describe '.album' do
    let(:result) do
      [
        { 'song' => 'the oracle on the delphi express' },
        { 'song' => 'red hands' },
        { 'song' => 'black sandy beaches' }
      ]
    end
    let(:expected) do
      [
        'the oracle on the delphi express',
        'red hands',
        'black sandy beaches'
      ]
    end

    before do
      allow(described_class).to receive(:genres).and_return(['genre'])
      allow(AwsService::DynamoDB).to receive(:query).and_return(result)
    end

    specify { expect(described_class.album('album')).to eq(expected) }
  end

  describe '.song' do
    let(:result) { ['s3_location' => 'url'] }
    let(:expected) { 'url' }

    before do
      allow(described_class).to receive(:genres).and_return(['genre'])
      allow(AwsService::DynamoDB).to receive(:query).and_return(result)
    end

    specify { expect(described_class.song('song')).to eq(expected) }
  end
end
