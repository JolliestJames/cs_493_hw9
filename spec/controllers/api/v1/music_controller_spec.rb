require 'rails_helper'

RSpec.describe Api::V1::MusicController, type: :controller do
  describe 'GET #index' do
    let(:expected) { { music: {'artist/album/song': 'some encoded song'} }.to_json }

    before do
      allow(MusicService).to receive(:encode_songs).and_return({'artist/album/song': 'some encoded song'})
    end

    specify { expect(get(:index).body).to eq(expected) }
  end
end
