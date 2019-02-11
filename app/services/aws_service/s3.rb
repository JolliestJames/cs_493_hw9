module AwsService
  class S3
    class << self
      def client
        @client ||= Aws::S3::Client.new(
          credentials: AwsService::Credentials.simple_storage_service,
          region: Rails.application.secrets.aws[:region]
        )
      end

      def put_object(object, path)
        client.put_object({
          body: File.read(object),
          bucket: bucket[:name],
          key: path,
          acl: 'public-read'
        })
      end

      def objects
        Aws::S3::Bucket.new(bucket[:name], client: client).objects.map { |o| o }
      end

      def object(key)
        client.get_object(bucket: bucket[:name], key: key)
      end

      def read(key)
        object(key).body.read
      end

      def object_url(key)
        Aws::S3::Object.new(bucket[:name], client: client, key: key).public_url
      end

      private

      def bucket
        buckets[:buckets].detect do |b|
          b[:name] == Rails.application.secrets.aws[:bucket_name]
        end
      end

      def buckets
        client.list_buckets
      end
    end
  end
end
