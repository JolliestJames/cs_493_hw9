require 'base64'

class MusicService
  class << self
    def encode_song(song)
      Base64.encode64(song)
    end

    def encode_songs
      encoded = {}
      songs.each do |song|
        song.each do |k, v|
          encoded = encoded.merge("#{k}": encode_song(v))
        end
      end
      encoded
    end

    def songs
      song_keys.map do |k|
        { "#{k.to_s}": AwsService::S3.object(k).body.read }
      end
    end

    def music
      collection = {}
      song_keys.map do |k|
        collection = collection.deep_merge(jsonify(k, song_url(k)))
      end
      collection
    end

    private

    attr_reader :song_keys

    def jsonify(key, url)
      artist, album, song = key.split('/')

      {
        "#{artist}": {
          "#{album}": {
            "#{song}": url
          }
        }
      }
    end

    def song_url(key)
      AwsService::S3.object_url(key)
    end

    def song_keys
      @song_keys ||= AwsService::S3.objects.map { |s| s.key }
    end
  end
end
