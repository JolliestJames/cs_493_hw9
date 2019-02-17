require 'rails_helper'

RSpec.describe Api::V2::MusicController, type: :controller do
  describe 'GET #genres' do
    let(:expected) { { genres: ['genre_1', 'genre_2', 'genre_3'] } }

    before do
      allow(MusicService::V2).to receive(:genres).and_return(expected[:genres])
    end

    specify { expect(get(:genres).body).to eq(expected.to_json) }
    specify { expect(get(:genres)).to be_successful }
  end

  describe 'GET #artists' do
    
  end

  describe 'GET #albums' do
    
  end

  describe 'GET #songs' do
    
  end

  describe 'GET #song' do
    
  end
end
