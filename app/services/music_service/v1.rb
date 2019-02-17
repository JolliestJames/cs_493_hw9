module MusicService
  class V1
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
        MusicService.song_keys.map do |k|
          { "#{k.to_s}": AwsService::S3.read(k) }
        end
      end

      def music
        collection = {}
        MusicService.song_keys.map do |k|
          collection = collection.deep_merge(
            MusicService.jsonify(
              k, MusicService.song_url(k)
            )
          )
        end
        collection
      end
    end
  end
end
