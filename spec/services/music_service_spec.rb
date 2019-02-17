require 'rails_helper'
require 'base64'

RSpec.describe MusicService do
  describe '.jsonify' do
    let(:key) { 'artist/album/song' }
    let(:url) { 'https://s3.amazonaws.com/neat-bucket/artist/album/song.mp3' }
    let(:expected) do
      {
        "artist": {
          "album": {
            "song": url
          }
        }
      }
    end

    specify { expect(described_class.jsonify(key, url)).to eq(expected) }
  end
end
