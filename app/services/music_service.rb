require 'base64'

module MusicService
  class << self
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
      AwsService::S3.objects.map { |s| s.key }
    end
  end
end
