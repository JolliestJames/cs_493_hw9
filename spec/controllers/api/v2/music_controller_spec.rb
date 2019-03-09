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
    let(:expected) { { artists: ['artist_1', 'artist_2', 'artist_3'] } }

    before do
      allow(MusicService::V2).to receive(:genre).and_return(expected[:artists])
    end

    it 'returns a list of artists belonging to a genre' do
      get :artists, params: { genre: 'genre' }

      expect(response.body).to eq(expected.to_json)
    end

    specify { expect(get(:artists, params: { genre: 'genre' })).to be_successful }
  end

  describe 'GET #albums' do
    let(:expected) { { albums: ['album_1', 'album_2', 'album_3'] } }

    before do
      allow(MusicService::V2).to receive(:artist).and_return(expected[:albums])
    end

    it 'returns a list of albums belonging to an artist' do
      get :albums, params: { artist: 'artist' }

      expect(response.body).to eq(expected.to_json)
    end

    specify { expect(get(:albums, params: { artist: 'artist' })).to be_successful }
  end

  describe 'GET #songs' do
    let(:expected) { { songs: ['song_1', 'song_2', 'song_3'] } }

    before do
      allow(MusicService::V2).to receive(:album).and_return(expected[:songs])
    end

    it 'returns a list of songs belonging to an album' do
      get :songs, params: { album: 'album' }

      expect(response.body).to eq(expected.to_json)
    end

    specify { expect(get(:songs, params: { album: 'album' })).to be_successful }
  end

  describe 'GET #song' do
    let(:expected) { { url: 'url' } }

    before do
      allow(MusicService::V2).to receive(:song).and_return(expected[:url])
    end

    it 'returns the S3 url of a song' do
      get :song, params: { song: 'song' }

      expect(response.body).to eq(expected.to_json)
    end

    specify { expect(get(:song, params: { song: 'song' })).to be_successful }
  end

  describe 'POST #play' do
    let(:expected) { { result: :ok } }

    before do
      allow(MusicService::V2).to receive(:play).and_return(:ok)
    end

    it 'returns http :accepted' do
      post :play, params: { artist: 'artist', album: 'album', song: 'song' }

      expect(response.body).to eq(expected.to_json)
    end
  end
end
