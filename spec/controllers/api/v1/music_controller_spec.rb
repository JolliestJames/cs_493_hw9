require 'rails_helper'

RSpec.describe Api::V1::MusicController, type: :controller do
  describe 'GET #index' do
    let(:expected) { { music: { 'artist': {'album': {'song': 'url' } } } } }

    before do
      allow(MusicService).to receive(:music).and_return(expected[:music])
    end

    specify { expect(get(:index).body).to eq(expected.to_json) }
  end
end
