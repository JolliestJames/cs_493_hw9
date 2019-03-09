module MusicService
  class V2
    class << self
      def genres
        AwsService::DynamoDB.scan(
          attr: 'genre',
          table: Rails.application.secrets.aws[:dynamo_db][:music]
        ).map { |i| i['genre'] }.to_set.to_a
      end

      def genre(key)
        AwsService::DynamoDB.query(
          genre: key,
          table: Rails.application.secrets.aws[:dynamo_db][:music]
        ).each.map { |item| item['artist'] }.to_set.to_a
      end

      def artist(key)
        genres.map do |g|
          AwsService::DynamoDB.query(
            genre: g,
            artist: key,
            method: :artist,
            table: Rails.application.secrets.aws[:dynamo_db][:music]
          )
        end.map { |r| r.each.map { |item| item['album'] } }.flatten.to_set.to_a
      end

      def album(key)
        genres.map do |g|
          AwsService::DynamoDB.query(
            genre: g,
            album: key,
            method: :album,
            table: Rails.application.secrets.aws[:dynamo_db][:music]
          )
        end.map { |r| r.each.map { |item| item['song'] } }.flatten.to_set.to_a
      end

      def song(key)
        genres.map do |g|
          AwsService::DynamoDB.query(
            genre: g,
            song: key,
            method: :song,
            table: Rails.application.secrets.aws[:dynamo_db][:music]
          )
        end.flatten.first['s3_location']
      end

      def play(opts)
        catch :error do
          throw :error, 'Failed to publish' unless AwsService::SQS.send(opts.to_json).message_id
          :ok
        end
      end
    end
  end
end
