module MusicService
  class V2
    class << self
      def genres
        AwsService::DynamoDB.scan('genre').map { |i| i['genre'] }.to_set.to_a
      end

      def genre(key)
        byebug
        AwsService::DynamoDB.query(genre: key).each.map { |item| item['artist'] }.to_set.to_a
      end

      def artist(key)
        genres.map do |g|
          AwsService::DynamoDB.query(genre: g, artist: key, method: :artist)
        end.map { |r| r.each.map { |item| item['album'] }.to_set.to_a }.flatten
      end

      def album(key)
        genres.map do |g|
          AwsService::DynamoDB.query(genre: g, album: key, method: :album)
        end.map { |r| r.each.map { |item| item['song'] }.to_set.to_a }.flatten
      end

      def song(key)
        genres.map do |g|
          AwsService::DynamoDB.query(genre: g, song: key, method: :song)
        end.first.first['s3_location']
      end
    end
  end
end
