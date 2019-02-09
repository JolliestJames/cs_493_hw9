require 'base64'

class MusicService
  class << self
    def encode_song(song)
      Base64.encode64(song)
    end

    def encode_songs
      songs.map { |s| encode_song s }
    end

    def songs
      song_keys.map do |k|
        AwsService::S3.object(k).body.read       
      end
    end

    private

    def song_keys
      AwsService::S3.objects.map { |s| s.key }
    end
  end
end
